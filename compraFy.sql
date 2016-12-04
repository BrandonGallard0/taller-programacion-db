/*
 * Shopping cart
 */

create table paises(
	id int not null primary key generated always as identity,
	nombre varchar(50) not null
);

create table regiones(
	id int not null primary key generated always as identity,
	pais_id int not null,
	nombre varchar(50) not null,
	constraint FK_region_pais foreign key (pais_id) references paises(id)
);

create table comunas(
	id int not null primary key generated always as identity,
	region_id int not null,
	nombre varchar(50) not null,
	constraint FK_comuna_region foreign key (region_id) references regiones(id)
);

create table roles(
	id int not null primary key generated always as identity,
	tipo varchar(20) not null
);


create table clientes(
	id int not null primary key generated always as identity,
	pais_id int not null,
	region_id int not null,
	comuna_id int not null,
	rol_id int not null,
	activado smallint not null,
	nombre varchar(50) not null,
	apellido varchar(50) not null,
	run varchar(20) not null,
	password varchar(255) not null,
	edad int not null,
	telefono varchar(20) not null,
	creado_el timestamp not null default current_timestamp,
	actualizado_el date not null,

	/* Foreign keys */

	constraint FK_cliente_pais foreign key (pais_id) references paises(id),
    constraint FK_cliente_region foreign key (region_id) references regiones(id),
    constraint FK_cliente_comuna foreign key (comuna_id) references comunas(id),
    constraint FK_cliente_rol foreign key (rol_id) references roles(id)
);


create table role_cliente(
	id int not null primary key generated always as identity,
	role_id int not null,
	cliente_id int not null,

	/* FOREIGN KEYS */
	constraint FK_role_cliente_rol foreign key (role_id) references roles(id),
	constraint FK_role_cliente_cliente foreign key (cliente_id) references clientes(id)
);

create table productos (
	id int not null primary key generated always as identity,
	foto varchar(255) not null,
	nombre varchar(50) not null,
	descripcion varchar(255) not null,
	precio int not null,
	stock int not null
);


/**
 * Forum
 */
create table preguntas(
    
    id int not null primary key generated always as identity,
    cliente_id int not null,
    pregunta varchar(255) not null,
    creado_el timestamp not null default current_timestamp,

    /* FOREIGN KEYS */
    /* pregunta --> cliente */
	constraint FK_pregunta_cliente foreign key (cliente_id) references clientes(id)
    
);

create table respuestas(

    id int not null primary key generated always as identity,
    pregunta_id int not null, 
    cliente_id int not null,
    respuesta varchar(255) not null,
    creado_el timestamp not null default current_timestamp,
	
	constraint FK_respuesta_pregunta foreign key (pregunta_id) references preguntas(id),

	/* respuesta --> cliente */
	constraint FK_respuesta_cliente foreign key (cliente_id) references clientes(id)
);
