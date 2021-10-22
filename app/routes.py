from flask import jsonify, request
from flask_jwt_extended import create_access_token, get_jwt_identity, jwt_required

from app import app, db, jwt, bcrypt
from app.models.Models import User, Categoria, Prenda, Unidad
from app.models.Schemas import UserSchema, CategoriaSchema, PrendaSchema, UnidadSchema

@app.route('/register', methods=['POST'])
def register():
    user_dict = UserSchema().load(request.get_json())
    user_dict["password"] = bcrypt.generate_password_hash(user_dict["password"]).decode("utf-8")
    user = User(**user_dict)
    db.session.add(user)
    db.session.commit()
    access_token = create_access_token(identity={"email": user_dict["email"]})
    return {"acces_token": access_token}

@app.route('/login', methods=['POST'])
def login():
    user_dict = UserSchema().load(request.get_json())
    user = User.query.filter_by(email=user_dict["email"]).first()
    if not user:
        return {"message": "user not found"}
    if bcrypt.check_password_hash(user.password, user_dict["password"]):
        access_token = create_access_token(identity={"email": user_dict["email"]})
        return {"acces_token": access_token}
    pass

@app.route('/categoria', methods=['GET'])
def get_all_categoria():
    schema = CategoriaSchema(many=True)
    categorias = Categoria.query.all()
    response = schema.dump(categorias)
    return jsonify(response)

@app.route('/prenda', methods=['GET'])
@jwt_required()
def get_all_prenda():
    schema = PrendaSchema(many=True)
    prendas = Prenda.query.all()
    response = schema.dump(prendas)
    return jsonify(response)

@app.route('/categoria', methods=['POST'])
def add_categoria():
    categoria_dict = CategoriaSchema().load(request.get_json())
    categoria = Categoria(**categoria_dict)
    db.session.add(categoria)
    db.session.commit()
    return "testing"

@app.route('/prenda', methods=['POST'])
def add_prenda():
    prenda_dict = PrendaSchema().load(request.get_json())
    categoria = Categoria.query.get(prenda_dict["categoria_id"])
    prenda = Prenda(**prenda_dict, categoria=categoria)
    db.session.add(prenda)
    db.session.commit()
    return "testing"
    

@app.route('/')
def home():
    return "Hola Mundo"
