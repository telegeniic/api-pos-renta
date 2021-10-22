from flask import jsonify, request

from app import app, db
from app.models.Models import Categoria, Prenda, Unidad
from app.models.Schemas import CategoriaSchema, PrendaSchema, UnidadSchema

@app.route('/categoria', methods=['GET'])
def get_all_categoria():
    schema = CategoriaSchema(many=True)
    categorias = Categoria.query.all()
    response = schema.dump(categorias)
    return jsonify(response)

@app.route('/prenda', methods=['GET'])
def get_all_prenda():
    schema = PrendaSchema(many=True)
    prendas = Prenda.query.all()
    response = schema.dump(prendas)
    return jsonify(response)

@app.route('/categoria', methods=['POST'])
def add_categoria():
    categoria = CategoriaSchema().load(request.get_json())
    print(categoria)
    Cat = Categoria(**categoria)
    print(Cat)
    db.session.add(Cat)
    db.session.commit()
    return "testing"

@app.route('/prenda', methods=['POST'])
def add_prenda():
    prenda = PrendaSchema().load(request.get_json())
    print(prenda)
    categoria = Categoria.query.get(prenda["categoria_id"])
    Pre = Prenda(**prenda, categoria=categoria)
    print(Pre)
    db.session.add(Pre)
    db.session.commit()
    return "testing"
    

@app.route('/')
def home():
    return "Hola Mundo"
