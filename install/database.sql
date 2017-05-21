drop table if exists feeds;

create table feeds(
  fid serial,
  name varchar(32) not null,
  link varchar(512) not null,
  tag varchar(16) default 'default',
  description varchar(1024),
  unique(name, link)
);
