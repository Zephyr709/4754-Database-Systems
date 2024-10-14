-- #1
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

-- #2
SELECT v.catalogid, v.categoryname, v.videoid, v.title
FROM video v

-- #3
SELECT v.title, count(*)
from video v
GROUP BY v.title
ORDER BY COUNT(*) ASC

-- #4
SELECT v.title, v.status, COUNT(*) 
FROM video v
where v.status = 'available'
GROUP BY v.title, v.status


-- #5
CREATE VIEW availableVideos AS
    SELECT v.title, v.status, COUNT(*) as count
    FROM video v
    where v.status = 'available'
    GROUP BY v.title, v.status
    

-- #6
SELECT v.title, v.status,v.categoryname, COUNT(*) as count
FROM video v
where v.status = 'available' and v.categoryname = 'drama'
GROUP BY v.title, v.status

-- #7
SELECT 
    c.name, c.customerid, v.title
from customer c, video v
where c.customerid in (
    select r.customerid
    from rental r
    where r.returndate is NULL
) AND v.videoid in (
    select r.videoid
    from rental r
    where r.returndate is NULL
)


-- #8
delimiter //
CREATE TRIGGER updateStatus 
AFTER update on rental
FOR EACH ROW
BEGIN
    update video
    set status = 'available'
    where catalogid = new.catalogid and videoid = new.videoid;
end //
delimiter ;

-- #9
delimiter //
create procedure returnBackVideo(
	in incatalogid int,
    in invideoid int,
    in incustomerid int,
    out totalfees float
)
begin 
	declare dailyRentalFee float;
    declare rentaldays int;
    declare rentdate date;
    declare retdate date;
    
    select dailyrentalfee into dailyRentalFee
    from video 
    where catalogid = incatalogid and videoid = invideoid;
    
    update rental
    set returndate = curdate()
    where catalogid = incatalogid and videoid = invideoid and customerid = incustomerid;
    
    set rentaldays = datediff(rentdate,retdate);
    set totalfees = rentaldays * dailyRentalFee;

end //
delimiter ;
    
-- #10
