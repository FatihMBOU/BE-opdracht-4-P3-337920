<?php

class BaseController
{
    // Laad het model
    public function model($model)
    {
        // Vereis het modelbestand
        require_once '../app/models/' . $model . '.php';
        // Instantieer het model
        return new $model();
    }

    // Laad de view
    public function view($view, $data = [])
    {
        // Controleer of de view bestaat
        if (file_exists('../app/views/' . $view . '.php')) {
            require_once '../app/views/' . $view . '.php';
        } else {
            // View bestaat niet
            die('View bestaat niet');
        }
    }
}