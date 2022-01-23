
CREATE TABLE crop (
    id integer PRIMARY KEY,
    common_name text,
    varietal text,
    notes text
);

CREATE TABLE gardener (
    name text PRIMARY KEY,
    email text,
    phone text
);

CREATE TABLE plot (
    number integer PRIMARY KEY,
    gardener text REFERENCES gardener(name),
    size text
);

CREATE TABLE plot_crop_xref (
    plot_number integer REFERENCES plot(number),
    crop_id integer REFERENCES crop(id),
    rows integer,
    PRIMARY KEY (plot_number, crop_id)
);

INSERT INTO crop SELECT * FROM midterm1.crop;
INSERT INTO gardener SELECT * FROM midterm1.gardener;
INSERT INTO plot SELECT * FROM midterm1.plot;
INSERT INTO plot_crop_xref SELECT * FROM midterm1.plot_crop_xref;


