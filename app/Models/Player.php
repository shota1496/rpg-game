<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Player extends Model
{
    //
    use HasFactory;

    // ★ この部分を追加します
    protected $fillable = [
        'user_id',
        'name',
        'level',
        'hp',
        'max_hp',
        'exp',
        'gold',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
