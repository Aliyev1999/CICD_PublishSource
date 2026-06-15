CREATE TABLE WPM_TaskTicketActionMapping(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    TaskTicketId INT NOT NULL,
    ActionId INT NOT NULL
)