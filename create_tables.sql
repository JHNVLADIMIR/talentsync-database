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
