from app import db

class Categoria(db.Model):
    __tablename__ = "categorias"
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(30))

    def __repr__(self):
        return f'{self.nombre}'

class Prenda(db.Model):
    __tablename__ = 'prendas'
    id = db.Column(db.Integer, primary_key=True)
    marca = db.Column(db.String(30))
    color = db.Column(db.String(20))
    talla = db.Column(db.String(4))
    precio = db.Column(db.Numeric(10,2))
    comentarios = db.Column(db.Text)
    categoria_id = db.Column(db.Integer, db.ForeignKey('categorias.id', ondelete="CASCADE"))
    categoria = db.relationship('Categoria', backref="prendas")

    def __repr__(self):
        return f'{self.marca} {self.color} {self.talla}'

class Unidad(db.Model):
    __tablename__ = 'unidades'
    id = db.Column(db.Integer, primary_key=True)
    comentarios = db.Column(db.Text)
    en_tienda = db.Column(db.Boolean, default=True)
    prenda_id = db.Column(db.Integer, db.ForeignKey('prendas.id', ondelete="CASCADE"))
    prenda = db.relationship('Prenda', backref='unidades')

    def __repr__(self):
        return f'prenda: {self.prenda_id}, {self.id}'

