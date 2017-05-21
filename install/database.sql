drop table if exists feeds;

create table feeds(
  fid serial,
  name varchar(32) not null,
  link varchar(512) not null,
  tag varchar(16) default 'default',
  description varchar(1024),
  unique(name, link)
);

drop table if exists keywords;

create table keywords(
  kid serial,
  word varchar(32) not null,
  unique(word)
);
