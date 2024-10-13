CREATE TABLE video (
    catalogid INT AUTO_INCREMENT NOT NULL, 
    videoid INT NOT null,
    title VARCHAR(100) not null,
    status ENUM('available','rented') not NULL,
    dailyrentalfee FLOAT not null,
    categoryname enum('Action','Adult','Children','Drama','Horror','Sci-Fi') not null,
    PRIMARY KEY (catalogid,videoid)
);

CREATE TABLE Customer(
    customerid INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) not NULL,
    regdate DATE not null,
    street VARCHAR(50) not NULL,
    city VARCHAR(50) not null,
    province VARCHAR(50) not null,
    postalcode VARCHAR(50) not null,

    PRIMARY KEY(customerid)
    
);


CREATE TABLE Rental (
    catalogid INT NOT NULL,
    videoid INT NOT NULL,
    customerid INT NOT NULL,
    rentdate DATE NOT NULL,
    returndate DATE,

    PRIMARY KEY(catalogid,videoid,customerid),
    FOREIGN KEY(catalogid,videoid) REFERENCES video(catalogid,videoid),
    FOREIGN KEY(customerid) references customer(customerid)
);


