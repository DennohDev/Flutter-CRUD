<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class product extends Model
{
    use HasFactory;

    // The model is used to fill in the data in the products table
    protected $fillable = [
        'name',
        'qty',
        'price',
        'description'
    ];
}
