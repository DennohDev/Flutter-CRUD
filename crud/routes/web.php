<?php

use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

// for the route below it uses a get method , the '/product' is the route of the file
// then we add the product controller and the method to be used in the product controller 
// make sure that your the method 'index' has been defined in your prouduct controller
// finally we name the route
// make sure you import the product controller
Route::get('/product', [ProductController::class, 'index'])->name('product.index');

Route::get('/product/create', [ProductController::class, 'create'])->name('product.create');

Route::post('/product', [ProductController::class, 'store'])->name('product.store');

Route::get('/product/{product}/edit', [ProductController::class, 'edit'])->name('product.edit');

Route::put('/product/{product}/update', [ProductController::class, 'update'])->name('product.update');

Route::delete('/product/{product}/delete', [ProductController::class, 'delete'])->name('product.delete');
