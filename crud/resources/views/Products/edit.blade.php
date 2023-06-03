<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Create Page</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="">
    </head>
    <body>
        <h1>Edit A Product</h1>
        <div>
            @if ($errors->any())
                <ul>
                    @foreach ($errors->all() as $error)
                    <li>{{$error}}</li>    
                    @endforeach
                </ul>
            @endif
        </div>
        <form method='POST' action="{{route('product.update', ['product'=> $product])}}">
            @csrf
            @method('put')
            <div>
                <label>Name</label>
                <input type='name' name='name' placeholder='name' value="{{$product->name}}">
            </div>
            <div>
                <label>Qty</label>
                <input type='qty' name='qty' placeholder='qty' value="{{$product->qty}}">
            </div>
            <div>
                <label>Price</label>
                <input type='price' name='price' placeholder='price' value="{{$product->price}}">
            </div>
            <div>
                <label>Description</label>
                <input type='description' name='description' placeholder='description' value="{{$product->description}}">
            </div>
            <input type='submit' value='Update'>
        </form>
    </body>
</html>