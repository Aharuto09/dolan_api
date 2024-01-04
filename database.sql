CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    url_profile VARCHAR(255)
);

CREATE TABLE Dolans (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    min_member INTEGER
);

CREATE TABLE Schedules (
    id SERIAL PRIMARY KEY,
    date_for VARCHAR(10),
    time_for VARCHAR(8),
    loc VARCHAR(255),
    address VARCHAR(255),
    id_group INTEGER REFERENCES Dolans(id)
);

CREATE TABLE Messages (
    id SERIAL PRIMARY KEY,
    id_schedule INTEGER REFERENCES Schedules(id),
    id_sender INTEGER REFERENCES Users(id),
   	content TEXT,
    create_date VARCHAR(10),
    create_time VARCHAR(8)
);

CREATE TABLE JoinGroups (
    id SERIAL PRIMARY KEY,
    id_user INTEGER REFERENCES Users(id),
    id_schedule INTEGER REFERENCES Schedules(id)
);

INSERT INTO Dolans (name, min_member)
VALUES ('Dolan Dungeon Pets', 5), ('Dolan Catan Special Edition', 8), ('Dolan Dungeon Plants', 3);

INSERT INTO Schedules (date_for, time_for, loc, address, id_group)
VALUES ('2024-02-04', '12-00', 'neko caffeine', 'jl. hirajuku', 1);

INSERT INTO Users (name, email, password, url_profile)
VALUES ('my name', 'user@mail.com', 'admin001', 'http://profile.png');