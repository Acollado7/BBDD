create database tienda;
use tienda;

create table proveedores(
id int not null auto_increment,
nombre varchar(50) not null,
direccion varchar(50) not null,
telefono varchar(50) not null,

constraint pk_proveedores primary key(id)
);

create table categorias(
id int not null auto_increment,
nombre varchar(50) not null,

constraint pk_categorias primary key(id)
);

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

insert into proveedores(nombre, direccion, telefono) values('proveedor1', 'direccion1', 'telefono1');
insert into proveedores(nombre, direccion, telefono) values('proveedor2', 'direccion2', 'telefono2');
insert into proveedores(nombre, direccion, telefono) values('proveedor3', 'direccion3', 'telefono3');

insert into categorias(nombre) values('categoria1');
insert into categorias(nombre) values('categoria2');
insert into categorias(nombre) values('categoria3');

insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('producto1', 100, 'descripcion1', 1, 1);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('producto2', 200, 'descripcion2', 2, 2);
insert into productos(nombre, precio, descripcion, proveedor_id, categoria_id) values('producto3', 300, 'descripcion3', 3, 3);

