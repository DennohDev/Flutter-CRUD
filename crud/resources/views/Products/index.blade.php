<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Products Page</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="">
    </head>
    <body>
        <h1>Products</h1>
        @if (session()->has('success'))
            <div>
                {{session('success')}}
            </div>
        @endif
        <div>
            <a href="{{route('product.create')}}">
                <button type="button">Add Products</button>
            </a>
            <table border="1">
                <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Quantitiy</th>
                <th>Price</th>
                <th>Description</th>
                <th>Edit</th>
                <th>Delete</th>
                </tr>
                @foreach ($products as $product )
                <tr>
                    <td>{{$product->id}}</td>
                    <td>{{$product->name}}</td>
                    <td>{{$product->qty}}</td>
                    <td>{{$product->price}}</td>
                    <td>{{$product->description}}</td>
                    <td><a href="{{route('product.edit', ['product' => $product])}}">Edit</a></td>
                    <td><form method='post' action="{{route('product.delete', ['product'=> $product])}}">
                        @csrf
                        @method('delete')
                        <input type="Submit" value="Delete">
                    </form></td>
                </tr>
                @endforeach
            </table>
        </div>
    </body>
</html>