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
        <h1>Create A Product</h1>
        <div>
            @if ($errors->any())
                <ul>
                    @foreach ($errors->all() as $error)
                    <li>{{$error}}</li>    
                    @endforeach
                </ul>
            @endif
        </div>
        <form method='POST' action="{{route('product.store')}}">
            @csrf
            @method('post')
            <div>
                <label>Name</label>
                <input type='name' name='name' placeholder='name'>
            </div>
            <div>
                <label>Qty</label>
                <input type='qty' name='qty' placeholder='qty'>
            </div>
            <div>
                <label>Price</label>
                <input type='price' name='price' placeholder='price'>
            </div>
            <div>
                <label>Description</label>
                <input type='description' name='description' placeholder='description'>
            </div>
            <input type='submit' value='Save Product'>
        </form>
    </body>
</html>