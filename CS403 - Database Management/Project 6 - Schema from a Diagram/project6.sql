/*
 *  project6.sql
 * 
 *  author: Nicholas McClellan
 *
 */
/* use the correct schema (does this even apply?) */

-- Just missing the relationship with business (belongs in the business table AFAIK)
create table chain (
	name text PRIMARY KEY,
	city text,
	state char(2)
);

-- Seems correct, but is the business_tpye supposed to just reference this table (I know its another table) ?
create table business (
	ID integer PRIMARY KEY,
	name text,
	street_address text,
	city text,
	state char(2),
	zip char(5),
	chain_name text,
	FOREIGN KEY(chain_name) REFERENCES chain(name)
);

-- Might be missing this 'views' but I honestly don't even know. I think this is just some sum (?)
create table reviewer (
	screen_name text,
	identity_provider text,
	PRIMARY KEY(screen_name, identity_provider)
);

-- I think I just need to change the way primary key, but TBH it is probably OK
create table menu (
	business_ID integer,
	label text,
	PRIMARY KEY(business_ID, label),
	url text,
	FOREIGN KEY(business_ID) REFERENCES business(ID)
);

-- Again, seems mostly correct, all of the attributes show, and any identifiers are included.
create table business_reviewer_xref (
	business_ID integer,
	reviewer_screen_name text,
	reviewer_identity_provider text,
	rating integer,
	review_date date,
	comments text,
	views integer,
	PRIMARY KEY(business_ID, reviewer_screen_name, reviewer_identity_provider),
	FOREIGN KEY(business_ID) REFERENCES business(ID),
	FOREIGN KEY(reviewer_screen_name, reviewer_identity_provider) REFERENCES reviewer(screen_name, identity_provider)
);

-- Seems at least mostly correct, and is referencing the 'business' table correctly.
create table business_type (
	business_ID integer,
	business_type text,
	PRIMARY KEY (business_ID, business_type),
	FOREIGN KEY (business_ID) REFERENCES business(ID)
);
