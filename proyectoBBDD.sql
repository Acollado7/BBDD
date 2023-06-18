
drop database if exists tienda;

create database if not exists tienda;
use tienda;

drop table if exists productos;
create table proveedores(
id int not null auto_increment,
nombre varchar(50) not null,
direccion varchar(50) not null,
telefono varchar(50) not null,

constraint pk_proveedores primary key(id)
);

drop table if exists categorias;
create table categorias(
id int not null auto_increment,
nombre varchar(50) not null,

constraint pk_categorias primary key(id)
);

drop table if exists productos;
create table productos(
id int not null auto_increment,
nombre varchar(50) not null,
precio float not null,
descripcion varchar(50) not null,
proveedor_id int not null,
categoria_id int not null,


constraint pk_productos primary key(id),
constraint fk_productos_proveedores foreign key(proveedor_id) references proveedores(id)

                        on    delete cascade,

constraint fk_productos_categorias foreign key(categoria_id) references categorias(id)

                      on    delete cascade
);
insert into proveedores(nombre, direccion, telefono) values('Miguel', 'Calle Carril de la Fuente 60', '717024054');
insert into proveedores(nombre, direccion, telefono) values('Maria', 'Calle Aduana 61', ' 660528691');
insert into proveedores(nombre, direccion, telefono) values('Pablo', ' Av. Zumalakarregi 47', '714499439');

insert into categorias(nombre) values('Informatica');
insert into categorias(nombre) values('Deportes');
insert into categorias(nombre) values('Hogar');

insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Portatil', 500, 'Portatil de 15 pulgadas', 1, 1);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Raton', 10, 'Raton inalambrico', 2, 1);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Teclado', 20, 'Teclado inalambrico', 3, 1);

insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Balon', 20, 'Balon de futbol', 1, 2);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Raqueta', 30, 'Raqueta de tenis', 2, 2);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Palas', 40, 'Palas de padel', 3, 2);

insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Sofa', 500, 'Sofa de 3 plazas', 1, 3);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Mesa', 100, 'Mesa de comedor', 2, 3);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('Silla', 50, 'Silla de comedor', 3, 3);


