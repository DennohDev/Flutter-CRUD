<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\product;
use GrahamCampbell\ResultType\Success;
use Illuminate\Container\RewindableGenerator;

class ProductController extends Controller
{
    public function index(){
        $products = product::all();
        return response()->json($products);
    }
    public function create(){
        return view ('products.create');
    }
    public function store(Request $request){
        $data = $request->validate([
            'name' => 'required',
            'qty' => 'required|numeric',
            'price' => 'required|decimal:0,2',
            'description'=> 'nullable'
        ]);

        $product = new Product();
        $product ->name=$request->post('name');
        $product ->qty =$request->post('qty');
        $product ->price =$request->post('price');
        $product ->description =$request->post('description');
        if($product ->save()){
            return response()->json([
                'success' =>true,
            ]);
        }
        else{
            return response()->json([
                'success' =>false,
            ]);
        }
    }

    public function show(Product $product){
        return response()->json($product);
    }
    public function update(product $product, Request $request) {
        $data = $request->validate([
            'name' => 'required',
            'qty' => 'required|numeric',
            'price' => 'required|decimal:0,2',
            'description'=> 'nullable'
        ]);
        
        $product ->save($data);
        $product ->name = $data['name'];
        $product ->qty = $data['qty'];
        $product ->price = $data['price'];
        $product ->description = $data['description'];
        $product ->save();
        return response()->json($product);
    }
    public function delete(product $product) {
        return response()->json($product->delete());
    }
}
