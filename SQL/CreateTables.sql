USE la_renta;

CREATE TABLE Categorias (
	ID_Categoria INTEGER NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),

	PRIMARY KEY (ID_Categoria)
);

CREATE TABLE Prendas(
	ID_Prenda INTEGER NOT NULL AUTO_INCREMENT,
    ID_Categoria INTEGER NOT NULL,
    Marca VARCHAR(30),
    Color VARCHAR(20),
    Talla VARCHAR(4),
    Precio DECIMAL(10,2),
    Comentarios TEXT,

	PRIMARY KEY (ID_Prenda),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria) ON DELETE CASCADE
);

CREATE TABLE Unidades(
	ID_Unidad INTEGER NOT NULL AUTO_INCREMENT,
    ID_Prenda INTEGER NOT NULL,
    Comentario TEXT,
    EnTienda BOOLEAN,
    
    FOREIGN KEY (ID_Prenda) REFERENCES Prendas(ID_Prenda) ON DELETE CASCADE,
	PRIMARY KEY (ID_unidad)
);

CREATE TABLE Clientes(
	ID_Cliente INTEGER NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
    Apellido VARCHAR(30),
    
    PRIMARY KEY(ID_Cliente)
);

CREATE TABLE Paises(
	ID_Pais INTEGER NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
	
    PRIMARY KEY (ID_Pais)
);

CREATE TABLE Estados(
	ID_Estado INTEGER NOT NULL AUTO_INCREMENT,
    ID_Pais INTEGER NOT NULL,
    Nombre VARCHAR(30),
    
    PRIMARY KEY (ID_Estado),
    FOREIGN KEY (ID_Pais) REFERENCES Paises(ID_Pais) ON DELETE CASCADE
);

CREATE TABLE Ciudades(
	ID_Ciudad INTEGER NOT NULL AUTO_INCREMENT,
    ID_Estado INTEGER NOT NULL,
    Nombre VARCHAR(30),
    
    PRIMARY KEY (ID_Ciudad),
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado) ON DELETE CASCADE
);

CREATE TABLE CodigosPostales(	
    CodigoPostal VARCHAR(5) NOT NULL,
    ID_Ciudad INTEGER NOT NULL,
    
    PRIMARY KEY (CodigoPostal),
    FOREIGN KEY (ID_Ciudad) REFERENCES Ciudades(ID_Ciudad) ON DELETE CASCADE
);

CREATE TABLE Colonias(
	ID_Colonia INTEGER NOT NULL AUTO_INCREMENT,
    CodigoPostal VARCHAR(5) NOT NULL,
    Nombre VARCHAR(30),
    
    PRIMARY KEY (ID_Colonia),
    FOREIGN KEY (CodigoPostal) REFERENCES CodigosPostales(CodigoPostal) ON DELETE CASCADE
);

CREATE TABLE Direcciones(
	ID_Direccion INTEGER NOT NULL AUTO_INCREMENT,
    ID_Cliente INTEGER NOT NULL,
    Calle VARCHAR(30),
    Numero VARCHAR(6),
    ID_Colonia INTEGER NOT NULL,

	PRIMARY KEY (ID_Direccion),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Colonia) REFERENCES Colonias(ID_Colonia) ON DELETE CASCADE
);

CREATE TABLE Telefonos(
	ID_Cliente INTEGER NOT NULL,
    Telefono VARCHAR(15),
    
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente) ON DELETE CASCADE,
    PRIMARY KEY(ID_Cliente, Telefono)
);

CREATE TABLE FormasPago(
	ID_FormaPago INTEGER NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(30),
	
    PRIMARY KEY (ID_FormaPago)
);

CREATE TABLE Facturas(
	ID_Factura INTEGER NOT NULL AUTO_INCREMENT,
    ID_Cliente INTEGER NOT NULL,
    FechaFactura DATE,
    FechaSalida DATE,
    FechaEvento DATE,
    FechaRegreso DATE,
    ID_FormaPago INTEGER NOT NULL,
    Costo DECIMAL(10,2),
    Deposito DECIMAL(10,2),
    Pago DECIMAL(10,2),
    Cerrado BOOLEAN,
    
    PRIMARY KEY (ID_Factura),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente) ON DELETE CASCADE,
    FOREIGN KEY (ID_FormaPago) REFERENCES FormasPago(ID_FormaPago) ON DELETE CASCADE
);

CREATE TABLE Transacciones(
    ID_Factura INTEGER NOT NULL,
    ID_Unidad INTEGER NOT NULL,
    
    PRIMARY KEY (ID_Factura, ID_Unidad),
    FOREIGN KEY (ID_Factura) REFERENCES Facturas(ID_Factura) ON DELETE CASCADE,
    FOREIGN KEY (ID_Unidad) REFERENCES Unidades(ID_Unidad) ON DELETE CASCADE
);