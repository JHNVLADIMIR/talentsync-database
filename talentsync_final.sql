-- TalentSync AI Recruitment Platform
-- Database schema and sample data

CREATE TABLE roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL
);

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    role_id INTEGER NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);

CREATE TABLE applicant_profiles (
    applicant_id INTEGER PRIMARY KEY,
    headline VARCHAR(150),
    resume_url VARCHAR(255),
    years_experience DECIMAL(4,1),
    education_level VARCHAR(50),
    location VARCHAR(100),
    FOREIGN KEY (applicant_id) REFERENCES users(user_id)
);

CREATE TABLE skills (
    skill_id INTEGER PRIMARY KEY,
    skill_name VARCHAR(80) NOT NULL,
    category VARCHAR(50)
);

CREATE TABLE applicant_skills (
    applicant_id INTEGER,
    skill_id INTEGER,
    proficiency_level VARCHAR(20),
    PRIMARY KEY (applicant_id, skill_id),
    FOREIGN KEY (applicant_id) REFERENCES applicant_profiles(applicant_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE job_postings (
    job_id INTEGER PRIMARY KEY,
    hr_id INTEGER,
    title VARCHAR(120) NOT NULL,
    description TEXT,
    employment_type VARCHAR(30),
    min_experience DECIMAL(4,1),
    status VARCHAR(20) DEFAULT 'Draft',
    posted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    closing_date DATE,
    FOREIGN KEY (hr_id) REFERENCES users(user_id)
);

CREATE TABLE job_required_skills (
    job_id INTEGER,
    skill_id INTEGER,
    importance_level VARCHAR(20),
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES job_postings(job_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE applications (
    application_id INTEGER PRIMARY KEY,
    job_id INTEGER NOT NULL,
    applicant_id INTEGER NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Submitted',
    match_score DECIMAL(5,2),
    FOREIGN KEY (job_id) REFERENCES job_postings(job_id),
    FOREIGN KEY (applicant_id) REFERENCES applicant_profiles(applicant_id)
);

CREATE TABLE assessments (
    assessment_id INTEGER PRIMARY KEY,
    job_id INTEGER NOT NULL,
    title VARCHAR(120) NOT NULL,
    passing_score DECIMAL(5,2) DEFAULT 70.00,
    FOREIGN KEY (job_id) REFERENCES job_postings(job_id)
);

CREATE TABLE assessment_questions (
    question_id INTEGER PRIMARY KEY,
    assessment_id INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    question_type VARCHAR(20),
    correct_answer TEXT,
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id)
);

CREATE TABLE application_assessment_results (
    result_id INTEGER PRIMARY KEY,
    application_id INTEGER NOT NULL,
    assessment_id INTEGER NOT NULL,
    score DECIMAL(5,2),
    completed_at TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id),
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id)
);

CREATE TABLE ai_prescreen_responses (
    response_id INTEGER PRIMARY KEY,
    application_id INTEGER NOT NULL,
    question_text TEXT NOT NULL,
    applicant_response TEXT,
    ai_flag_notes VARCHAR(255),
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);

CREATE TABLE interviews (
    interview_id INTEGER PRIMARY KEY,
    application_id INTEGER NOT NULL,
    hr_id INTEGER,
    scheduled_at TIMESTAMP,
    mode VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Scheduled',
    feedback TEXT,
    FOREIGN KEY (application_id) REFERENCES applications(application_id),
    FOREIGN KEY (hr_id) REFERENCES users(user_id)
);

CREATE TABLE notifications (
    notification_id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    message VARCHAR(255) NOT NULL,
    type VARCHAR(30),
    is_read BOOLEAN DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Sample data

INSERT INTO roles (role_id, role_name) VALUES
(1, 'Applicant'), (2, 'HR'), (3, 'HiringManager'), (4, 'Admin'), (5, 'SuperAdmin');

INSERT INTO users (user_id, role_id, full_name, email, password_hash, phone) VALUES
(1, 1, 'Maria Santos', 'maria.santos@gmail.com', 'hash1', '09171234501'),
(2, 1, 'Carlo Dizon', 'carlo.dizon@yahoo.com', 'hash2', '09171234502'),
(3, 1, 'Ella Ramirez', 'ella.ramirez@gmail.com', 'hash3', '09171234503'),
(4, 1, 'Miguel Torres', 'miguel.torres@outlook.com', 'hash4', '09171234504'),
(5, 1, 'Bea Fernandez', 'bea.fernandez@gmail.com', 'hash5', '09171234505'),
(6, 2, 'Karen Reyes', 'karen.reyes@ucos.com', 'hash6', '09189876501'),
(7, 2, 'James Cruz', 'james.cruz@ucos.com', 'hash7', '09189876502'),
(8, 3, 'Patricia Lim', 'patricia.lim@ucos.com', 'hash8', '09189876503'),
(9, 4, 'Noel Bautista', 'noel.bautista@ucos.com', 'hash9', '09189876504'),
(10, 5, 'Sofia Villareal', 'sofia.villareal@ucos.com', 'hash10', '09189876505');

INSERT INTO applicant_profiles (applicant_id, headline, resume_url, years_experience, education_level, location) VALUES
(1, 'Junior Web Developer', 'https://cdn.talentsync.io/resumes/1.pdf', 1.5, 'BS Information Technology', 'Imus, Cavite'),
(2, 'Data Entry & Admin Support Specialist', 'https://cdn.talentsync.io/resumes/2.pdf', 3.0, 'BS Business Administration', 'Dasmarinas, Cavite'),
(3, 'Aspiring UI/UX Designer', 'https://cdn.talentsync.io/resumes/3.pdf', 0.5, 'BS Multimedia Arts', 'Bacoor, Cavite'),
(4, 'Backend Developer', 'https://cdn.talentsync.io/resumes/4.pdf', 4.0, 'BS Computer Science', 'Manila'),
(5, 'Customer Support Representative', 'https://cdn.talentsync.io/resumes/5.pdf', 2.0, 'Associate in Computer Technology', 'Cavite City');

INSERT INTO skills (skill_id, skill_name, category) VALUES
(1, 'JavaScript', 'Technical'),
(2, 'SQL', 'Technical'),
(3, 'Figma', 'Design'),
(4, 'Customer Service', 'Soft Skill'),
(5, 'Python', 'Technical'),
(6, 'Project Coordination', 'Soft Skill');

INSERT INTO applicant_skills (applicant_id, skill_id, proficiency_level) VALUES
(1, 1, 'Intermediate'),
(1, 2, 'Beginner'),
(2, 4, 'Advanced'),
(2, 6, 'Intermediate'),
(3, 3, 'Intermediate'),
(4, 2, 'Advanced'),
(4, 5, 'Advanced'),
(5, 4, 'Advanced');

INSERT INTO job_postings (job_id, hr_id, title, description, employment_type, min_experience, status, closing_date) VALUES
(1, 6, 'Junior Web Developer', 'Build and maintain client-facing web features for internal HR tools.', 'Full-time', 1.0, 'Active', '2026-11-30'),
(2, 6, 'Backend Developer', 'Design and maintain REST APIs and the applicant-matching database.', 'Full-time', 2.0, 'Active', '2026-12-15'),
(3, 7, 'UI/UX Designer', 'Design user flows and interfaces for the applicant-facing dashboard.', 'Full-time', 0.0, 'Active', '2026-11-20'),
(4, 7, 'Customer Support Representative', 'Handle applicant inquiries via chat and email.', 'Full-time', 1.0, 'Active', '2026-10-31'),
(5, 6, 'Data Entry Specialist', 'Maintain accurate records across recruitment databases.', 'Part-time', 1.0, 'Closed', '2026-09-01');

INSERT INTO job_required_skills (job_id, skill_id, importance_level) VALUES
(1, 1, 'Required'),
(1, 2, 'Preferred'),
(2, 2, 'Required'),
(2, 5, 'Required'),
(3, 3, 'Required'),
(4, 4, 'Required'),
(5, 6, 'Preferred');

INSERT INTO applications (application_id, job_id, applicant_id, status, match_score) VALUES
(1, 1, 1, 'Shortlisted', 88.50),
(2, 2, 4, 'Interview', 92.00),
(3, 3, 3, 'Screening', 74.25),
(4, 4, 5, 'Shortlisted', 81.00),
(5, 5, 2, 'Rejected', 55.00);

INSERT INTO assessments (assessment_id, job_id, title, passing_score) VALUES
(1, 1, 'JavaScript Fundamentals Quiz', 70.00),
(2, 2, 'SQL & API Design Test', 75.00),
(3, 3, 'UI/UX Design Challenge', 70.00),
(4, 4, 'Customer Service Scenario Test', 65.00),
(5, 5, 'Data Accuracy Timed Test', 70.00);

INSERT INTO assessment_questions (question_id, assessment_id, question_text, question_type, correct_answer) VALUES
(1, 1, 'What keyword declares a block-scoped variable in JavaScript?', 'MultipleChoice', 'let'),
(2, 1, 'Write a function that returns the sum of two numbers.', 'Coding', 'function sum(a, b) { return a + b; }'),
(3, 2, 'Which SQL clause filters rows after aggregation?', 'MultipleChoice', 'HAVING'),
(4, 3, 'Describe your process for designing a mobile onboarding flow.', 'ShortAnswer', NULL),
(5, 4, 'How would you handle an upset customer over chat?', 'ShortAnswer', NULL);

INSERT INTO application_assessment_results (result_id, application_id, assessment_id, score, completed_at) VALUES
(1, 1, 1, 85.00, '2026-09-10 14:00:00'),
(2, 2, 2, 90.00, '2026-09-11 09:30:00'),
(3, 3, 3, 78.00, '2026-09-11 16:45:00'),
(4, 4, 4, 82.00, '2026-09-12 10:15:00'),
(5, 5, 5, 60.00, '2026-08-28 13:20:00');

INSERT INTO ai_prescreen_responses (response_id, application_id, question_text, applicant_response, ai_flag_notes) VALUES
(1, 1, 'Why are you interested in this role?', 'I enjoy building fast, accessible web interfaces.', NULL),
(2, 2, 'Describe a time you optimized a slow database query.', 'Refactored an N+1 query into a single JOIN, cutting load time by 70%.', NULL),
(3, 3, 'What is your expected salary range?', 'PHP 25,000-30,000', 'Within posted budget range'),
(4, 4, 'Are you available for weekend shifts?', 'Yes, fully available.', NULL),
(5, 5, 'Explain the 8-month gap in your work history.', 'Took care of a family member during that period.', 'Employment gap explained');

INSERT INTO interviews (interview_id, application_id, hr_id, scheduled_at, mode, status, feedback) VALUES
(1, 1, 6, '2026-09-20 10:00:00', 'Video', 'Scheduled', NULL),
(2, 2, 6, '2026-09-18 13:00:00', 'Onsite', 'Completed', 'Strong technical foundation, communicates clearly.'),
(3, 4, 7, '2026-09-19 15:00:00', 'Video', 'Scheduled', NULL),
(4, 3, 7, '2026-09-22 11:00:00', 'Video', 'Scheduled', NULL),
(5, 5, 6, '2026-09-05 09:00:00', 'Phone', 'Cancelled', 'Applicant withdrew before the call.');

INSERT INTO notifications (notification_id, user_id, message, type, is_read) VALUES
(1, 1, 'Your application for Junior Web Developer has been shortlisted.', 'ApplicationUpdate', 0),
(2, 4, 'Interview scheduled for Backend Developer on Sep 18.', 'InterviewReminder', 1),
(3, 5, 'Your application for Customer Support Representative is under review.', 'ApplicationUpdate', 0),
(4, 6, 'New applicant matched 92% for Backend Developer.', 'SystemAlert', 0),
(5, 2, 'Thank you for applying. We moved forward with other candidates.', 'ApplicationUpdate', 1);

-- Queries

-- Applicants with a match score of 80 or higher
SELECT application_id, job_id, applicant_id, status, match_score
FROM applications
WHERE match_score >= 80
ORDER BY match_score DESC;

-- Applicant name, job title, and application status
SELECT u.full_name AS applicant_name, jp.title AS job_title, a.status, a.match_score
FROM applications a
JOIN applicant_profiles ap ON ap.applicant_id = a.applicant_id
JOIN users u ON u.user_id = ap.applicant_id
JOIN job_postings jp ON jp.job_id = a.job_id
ORDER BY a.match_score DESC;

-- Number of applications per job posting
SELECT jp.title, COUNT(a.application_id) AS total_applications
FROM job_postings jp
LEFT JOIN applications a ON a.job_id = jp.job_id
GROUP BY jp.job_id, jp.title
ORDER BY total_applications DESC;

-- Average assessment score per job posting
SELECT jp.title AS job_title, asmt.title AS assessment_title, ROUND(AVG(r.score), 2) AS avg_score
FROM application_assessment_results r
JOIN assessments asmt ON asmt.assessment_id = r.assessment_id
JOIN job_postings jp ON jp.job_id = asmt.job_id
GROUP BY jp.job_id, asmt.assessment_id
ORDER BY avg_score DESC;

-- Number of required skills per active job posting
SELECT jp.title, COUNT(jrs.skill_id) AS required_skill_count
FROM job_postings jp
JOIN job_required_skills jrs ON jrs.job_id = jp.job_id
WHERE jp.status = 'Active'
GROUP BY jp.job_id, jp.title
ORDER BY required_skill_count DESC;
