<?php

namespace App\Model;

use Nette;

class Village
{
    /** @var Nette\Database\Context */
    private $database;

    
    public function __construct(Nette\Database\Context $database)
    {
        $this->database = $database;
    }
    

    public function getVillages()
    {
        return $this->database->fetchPairs('SELECT id_village, name_village FROM village');

    }
}
