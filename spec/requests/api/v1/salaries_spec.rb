require "rails_helper"

RSpec.describe "Salaries API", type: :request do
  let(:admin) { create(:user, :admin) }
  let(:hr_manager) { create(:user, :hr_manager) }
  let(:hr) { create(:user, :hr) }
  let(:engineer) { create(:user) }

  describe "GET /api/v1/salaries" do
    let!(:salary_record) { create(:salary_record) }

    it "returns 401 without a token" do
      get "/api/v1/salaries"

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 403 for roles that can't view salaries" do
      get "/api/v1/salaries", headers: auth_headers(engineer)

      expect(response).to have_http_status(:forbidden)
    end

    [ :admin, :hr_manager, :hr ].each do |role|
      it "lists salary records with their role for #{role.to_s.humanize}" do
        get "/api/v1/salaries", headers: auth_headers(public_send(role))

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to contain_exactly(
          include(
            "id" => salary_record.id,
            "user_id" => salary_record.user_id,
            "role" => { "id" => salary_record.role.id, "name" => salary_record.role.name }
          )
        )
      end
    end
  end

  describe "POST /api/v1/salaries" do
    let(:salary_record) { create(:salary_record, compensation: 85_000) }
    let(:params) do
      {
        id: salary_record.id,
        salary_record: { compensation: 120_000, currency: "USD", effective_from: "2026-10-01" }
      }
    end

    def update_salary(user, body = params)
      post "/api/v1/salaries", params: body, headers: auth_headers(user), as: :json
    end

    [ :admin, :hr_manager ].each do |role|
      it "updates the salary for #{role.to_s.humanize}" do
        update_salary(public_send(role))

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to include(
          "message" => "Salary record updated and employment history created successfully",
          "salary_record" => include("id" => salary_record.id, "currency" => "USD"),
          "employment_history" => include("user_id" => salary_record.user_id, "currency" => "USD")
        )
        expect(salary_record.reload.compensation).to eq(120_000)
      end
    end

    [ :hr, :engineer ].each do |role|
      it "returns 403 for #{role.to_s.humanize} and leaves the salary unchanged" do
        expect { update_salary(public_send(role)) }.not_to change(EmploymentHistory, :count)

        expect(response).to have_http_status(:forbidden)
        expect(response.parsed_body).to eq("error" => "You don't have permission to update salaries")
        expect(salary_record.reload.compensation).to eq(85_000)
      end
    end

    it "returns 401 without a token" do
      post "/api/v1/salaries", params: params, as: :json

      expect(response).to have_http_status(:unauthorized)
    end

    it "returns 404 for an unknown salary record" do
      update_salary(admin, params.merge(id: 0))

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body).to eq("error" => "Salary record not found")
    end

    it "returns 422 with validation errors" do
      update_salary(admin, params.deep_merge(salary_record: { compensation: -5 }))

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.parsed_body).to eq("errors" => [ "Compensation must be greater than 0" ])
    end

    it "returns 400 when the salary fields are missing" do
      update_salary(admin, { id: salary_record.id })

      expect(response).to have_http_status(:bad_request)
    end

    it "ignores fields that can't be changed" do
      other_user = create(:user)

      update_salary(admin, params.deep_merge(salary_record: { user_id: other_user.id }))

      expect(salary_record.reload.user_id).not_to eq(other_user.id)
    end
  end
end
