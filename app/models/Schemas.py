from app import ma
from .Models import User, Categoria, Prenda, Unidad

class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = User

class CategoriaSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Categoria

class PrendaSchema(ma.SQLAlchemyAutoSchema):
    categoria = ma.Nested(CategoriaSchema)
    class Meta:
        model = Prenda
        include_fk = True

class UnidadSchema(ma.SQLAlchemyAutoSchema):
    prenda = ma.Nested(PrendaSchema)
    class Meta:
        model = Unidad
        include_fk = True