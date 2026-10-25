# Paywise — Technical Requirements and Architecture

## 1. Project Overview

Paywise is an employee management and compensation application built using React, TypeScript, Ruby on Rails, and PostgreSQL.

The application provides employee information management, role-based access control, salary management, and employment history tracking.

The system follows a decoupled architecture, with React responsible for the user interface and Rails providing REST APIs, authentication, authorization, and business logic.

### Technology Stack

| Technology | Purpose |
|---|---|
| React | Frontend user interface |
| TypeScript | Type safety and maintainable frontend code |
| Vite | Frontend development and build tooling |
| Ruby on Rails | Backend application and REST APIs |
| PostgreSQL | Relational data storage |
| JWT | API authentication |
| CanCanCan | Role-based authorization |
| Active Record | Database interactions and associations |
| Rails migrations and seeds | Database schema management and sample data |

The frontend and backend are maintained as separate applications, allowing independent development and deployment.

---

## 2. Requirements Understanding

### 2.1 Employee Management

The application maintains employee information, including:

- Employee ID and name
- Email address
- Role
- Hire date
- Country
- Contact information
- Address

Each employee is associated with a role through `role_id`.

Employee APIs provide the information required by the frontend, including the role name, so users can understand employee designations without relying on numeric identifiers.

### 2.2 Authentication

The application uses JSON Web Tokens (JWT) to authenticate users accessing protected APIs.

The authentication workflow includes:

1. The user submits an email address and password.
2. The backend normalizes the email and locates the corresponding user.
3. Rails verifies the password using the model's authentication mechanism.
4. If authentication succeeds, the backend generates a JWT.
5. The response contains the token and the authenticated user's basic information, including their role.
6. Subsequent protected requests use the token to establish the authenticated user.

Invalid credentials return an HTTP `401 Unauthorized` response.

Example login response:

```json
{
  "token": "<jwt_token>",
  "user": {
    "id": 10000,
    "name": "Daniel Martin",
    "email": "daniel@example.com",
    "role_id": 4,
    "role_name": "Senior Software Engineer"
  }
}
```

The values above illustrate the response structure.

### 2.3 Role-Based Access Control

The application uses CanCanCan to enforce permissions based on user roles.

The authorization model distinguishes authentication from authorization: identifying a user does not automatically grant permission to perform every operation.

The intended access model is:

| Operation | Admin | HR Manager | HR |
|---|---|---|---|
| View employee records | Yes | Yes | Yes |
| View salary records | Yes | Yes | As permitted by the salary-visibility policy |
| Update salary records | Yes | Yes | No |
| Delete salary records | As configured | No | No |
| Manage application roles | Authorized administrative access | No by default | No |

The final permissions are enforced by the Rails backend rather than relying exclusively on frontend controls.

Role names are normalized before comparison to avoid inconsistent authorization results caused by leading or trailing whitespace.

### 2.4 Salary Management

Salary records maintain employee compensation information.

Each record includes:

- Employee reference
- Role reference
- Compensation amount
- Currency
- Effective date
- Creation and update timestamps

Authorized users can update compensation, currency, and the effective date.

The API provides appropriate responses for successful updates, validation failures, unauthorized access, and missing records.

The salary update workflow also creates a corresponding employment-history entry, according to the current application requirement.

### 2.5 Employment History

Employment history provides a record of an employee's professional background.

The `employment_histories` table contains:

| Field | Description |
|---|---|
| `user_id` | Employee associated with the record |
| `company_name` | Company name |
| `designation` | Job designation |
| `salary` | Compensation associated with the record |
| `currency` | Compensation currency |
| `started_on` | Employment start date |
| `ended_on` | Employment end date, if applicable |

Sample data includes five employment-history records for each of two employees, supporting demonstration of employment history and compensation information.

---

## 3. Application Architecture

Paywise separates presentation, API handling, authorization, business operations, and persistence.

### Architecture Diagram

```text
                 +--------------------------+
                 |      React Frontend      |
                 |                          |
                 | Authentication UI        |
                 | Employee Management      |
                 | Salary Management        |
                 | Employment History       |
                 +------------+-------------+
                              |
                              | HTTP / JSON
                              | Bearer JWT
                              |
                 +------------v-------------+
                 |       Rails API          |
                 |                          |
                 | API v1 Controllers       |
                 | Request Handling         |
                 | Response Serialization   |
                 +------------+-------------+
                              |
                 +------------v-------------+
                 | Authentication &         |
                 | Authorization            |
                 |                          |
                 | JWT Validation           |
                 | Current User Resolution  |
                 | CanCanCan Permissions    |
                 +------------+-------------+
                              |
                 +------------v-------------+
                 | Application Logic        |
                 |                          |
                 | Employee Operations      |
                 | Salary Updates            |
                 | Employment History        |
                 | Data Validation          |
                 +------------+-------------+
                              |
                 +------------v-------------+
                 |       PostgreSQL         |
                 |                          |
                 | Users                    |
                 | Roles                    |
                 | Salary Records            |
                 | Employment Histories      |
                 +--------------------------+
```

The diagram represents the logical application architecture.

### 3.1 Frontend Responsibilities

The React application is responsible for:

- Rendering employee and salary information.
- Collecting user input.
- Calling backend APIs.
- Displaying validation and API errors.
- Managing the frontend authentication state.
- Presenting available actions according to user permissions.

### 3.2 Backend Responsibilities

The Rails application is responsible for:

- Authentication and token validation.
- Authorization and access enforcement.
- Request validation.
- Business logic execution.
- Database operations.
- Consistent HTTP status codes and JSON responses.

The backend remains the authoritative enforcement point for access control.

### 3.3 API Versioning

The backend organizes endpoints under the `Api::V1` namespace.

For example:

`Api::V1::SalaryRecordsController`

API versioning establishes a clear structure for evolving endpoints while maintaining compatibility with existing clients.

---

## 4. Authentication Design — JWT

JWT provides token-based authentication between the React frontend and Rails backend.

After successful authentication, the backend generates a signed token associated with the authenticated user's identifier.

For protected requests, the client sends the token through the HTTP Authorization header:

```http
Authorization: Bearer <jwt_token>
```

The backend validates the token and resolves the current user before processing the request.

### Security Measures

- Password verification is handled on the backend.
- Password digests are excluded from API responses.
- Protected endpoints require authentication.
- Tokens are validated before the associated user is trusted.
- Authentication and authorization are handled as separate concerns.
- The JWT signing secret is maintained through Rails credentials or another appropriate secret-management mechanism.

The token's expiration, storage, and invalidation behavior are important parts of the overall authentication design.

---

## 5. Authorization Design — CanCanCan

CanCanCan provides a centralized mechanism for expressing application permissions.

The application identifies the current user and evaluates whether their role permits the requested operation.

For example, salary updates are restricted to the Admin and HR Manager roles.

This approach ensures that access restrictions are enforced on the backend, including when requests are made directly to the API rather than through the React interface.

Role assignment is a security-sensitive operation because roles determine application permissions. It should therefore be restricted to explicitly authorized administrative actions.

---

## 6. Database Design

The application uses PostgreSQL with Active Record to manage relational data.

### Core Entities

**Users**
- Stores employee information.
- References a role.
- Associates an employee with salary and employment-history records.

**Roles**
- Stores application role definitions.
- Provides the role names used by the authorization system.

**Salary Records**
- Stores compensation information for employees.
- References the associated employee and role.
- Records the compensation currency and effective date.

**Employment Histories**
- Stores employment and designation information associated with employees.
- Records compensation-related details and employment dates.

### Relationships

```text
Role
 |
 | 1
 |
 | N
User
 |
 | 1
 +---------------------+
 |                     |
 | N                   | N
SalaryRecord      EmploymentHistory
 |
 | N
 |
Role
```

These relationships are represented through Active Record associations and database foreign keys.

Database migrations provide a version-controlled way to evolve the schema as application requirements change.

---

## 7. Salary Update Workflow

The salary update endpoint follows a structured request lifecycle.

1. The backend authenticates the request.
2. Authorization checks determine whether the user can update salary information.
3. The salary record is retrieved.
4. The request parameters are restricted to permitted salary attributes.
5. The salary record is validated and updated.
6. A new employment-history record is created when the salary update succeeds.
7. Related database writes are executed within a transaction.
8. The API returns the updated record or an appropriate error response.

### HTTP Response Handling

| Scenario | HTTP status |
|---|---|
| Successful update | `200 OK` |
| Invalid input | `422 Unprocessable Entity` |
| Missing salary record | `404 Not Found` |
| Unauthorized user | `403 Forbidden` |
| Unauthenticated request | `401 Unauthorized` |

Transactions maintain consistency between the salary update and its associated employment-history entry.

---

## 8. Performance Considerations

### 8.1 Eager Loading

Active Record eager loading is used when associated data must be included in API responses.

For example:

```ruby
SalaryRecord.includes(:role)
```

This reduces unnecessary database queries when serializing role information for multiple salary records.

### 8.2 Database Indexes

Indexes on foreign-key columns support common joins and lookups.

The current schema includes indexes on relevant columns such as:

- `users.role_id`
- `salary_records.user_id`
- `salary_records.role_id`
- `employment_histories.user_id`

Additional indexes should be based on query patterns and database performance measurements.

### 8.3 Pagination

Employee and salary endpoints should paginate large collections instead of returning all records in one response.

Pagination reduces response sizes, database work per request, network transfer, and frontend memory consumption.

### 8.4 Bulk Data Seeding

Rails seed scripts generate sample employee, salary, and employment-history data.

Batch insertion is used for large collections to reduce the overhead of inserting records individually.

Because bulk insertion bypasses normal Active Record validations and callbacks, the generated data should be validated before insertion.

### 8.5 Transactional Data Integrity

Salary updates and corresponding employment-history creation are grouped in a database transaction.

This prevents a successful salary update from being committed without its required history entry when the second operation fails.

### 8.6 API Response Design

API responses expose the fields needed by the frontend instead of indiscriminately returning every database attribute.

Sensitive information, particularly password digests, must not be exposed.

---

## 9. Testing Strategy

Testing focuses on application behavior, security, data integrity, and performance.

### Authentication
- Valid credentials produce a JWT.
- Invalid credentials return 401.
- Protected endpoints reject unauthenticated requests.
- Invalid or expired tokens are rejected.
- Sensitive authentication data is not exposed.

### Authorization
- Admin and HR Manager can perform permitted salary updates.
- HR cannot update salary records.
- Direct API requests cannot bypass backend authorization.
- Unauthorized role changes are rejected.

### Salary Management
- Valid salary updates succeed.
- Invalid attributes return validation errors.
- Missing records return 404.
- Unauthorized updates return 403.
- Successful updates create the required employment-history entry.
- Failed operations do not leave inconsistent database records.

### Database and Performance
- Employee and role associations return the expected data.
- Salary endpoints avoid unnecessary repeated queries.
- Foreign-key relationships remain valid.
- Large result sets are handled using pagination.

---

## 10. AI-Assisted Development

AI tools were used as an engineering assistant for implementation guidance, code review, debugging, and technical documentation.

The developer remains responsible for validating generated code, checking the actual database schema, and verifying behavior through tests.

### Representative Prompts

**Authentication**

"Review the Rails JWT authentication implementation. Verify token generation, decoding, current-user resolution, error handling, and security concerns. Explain the changes required to make protected API requests work correctly."

**Authorization**

"Implement role-based authorization using CanCanCan. Admin and HR Manager should be allowed to update salary records, while HR should have read-only access. Enforce permissions on the backend."

**Database Integrity**

"Review the salary update workflow. Ensure salary changes and the required employment-history entry are committed together, and that validation failures return appropriate HTTP responses."

**Performance**

"Review the Rails API for N+1 queries, unnecessary database calls, response payload size, indexes, and pagination. Recommend practical improvements appropriate to the application."

**Code Review**

"Review this Rails controller from a senior software engineer's perspective. Identify security issues, incorrect assumptions, transaction concerns, and opportunities to improve maintainability and testability."

**Documentation**

"Prepare technical documentation covering the application's requirements, architecture, authentication, authorization, database relationships, performance considerations, and testing strategy."

These prompts illustrate the types of AI-assisted engineering tasks used during development. They are representative examples, not a verbatim transcript of the original interactions.

### Responsible AI Usage

AI-generated suggestions are reviewed against the actual application code and schema.

The development process includes:
- Validating proposed changes before applying them.
- Reviewing generated migrations and associations.
- Testing authorization and error handling.
- Avoiding the use of secrets or sensitive production data in prompts.
- Verifying that proposed code matches the application's actual requirements.

---

## 11. Implementation Summary

Paywise brings together employee management, compensation data, authentication, and role-based access control through a React frontend and Rails backend.

The implementation includes:

- A versioned Rails API.
- JWT-based login.
- Role information in authenticated user responses.
- CanCanCan-based authorization.
- Employee and role associations.
- Salary record management.
- Employment-history records and sample data.
- Transactional handling of related salary and history updates.
- Eager loading for associated role data.
- Structured API error responses.

The architecture separates frontend presentation from backend business responsibilities and uses PostgreSQL to maintain relational data integrity.

## Conclusion

Paywise demonstrates a full-stack application architecture combining React, TypeScript, Ruby on Rails, PostgreSQL, JWT authentication, and CanCanCan authorization.

The implementation emphasizes secure API access, clear separation of responsibilities, relational data modeling, transactional consistency, and performance-aware database interactions.