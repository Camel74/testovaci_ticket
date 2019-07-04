<?php

namespace App\Model;

use Nette;

class RightManager
{
    /** @var Nette\Database\Context */
    private $database;
    
    private $rightVillages;
    
    private $village;

    
    public function __construct(Nette\Database\Context $database, Village $village)
    {
        $this->database = $database;
        $this->village = $village;
    }
    
    
    public function getRight($uid, $right)
    {
        $rightVillages = array();
        $field = 'right_' . $right;
        
        if($this->existUser($uid)) {
            $villages = $this->village->getVillages();

            if(!$this->existRightsUser($uid)) {
                return $villages;
            }

            $result = $this->database->query('SELECT id_user_admin FROM accessright '
                    . 'WHERE id_user_admin = ? '
                    . 'AND ?name = 1', $uid, $field);
            $isBanVillages = $result->getRowCount();

            foreach ($villages as $key => $village) {
                $right = $this->database->fetchField('SELECT ?name FROM accessright '
                        . 'WHERE id_user_admin = ? '
                        . 'AND id_village = ?', $field, $uid, $key);

                if($right !== false) {
                     if($right === 0) {
                        $rightVillages[$key] = $village;
                    }

                } else {
                    if(!$isBanVillages) {
                        $rightVillages[$key] = $village;
                    }
                }
            }
        }
        
        return $rightVillages;
    }
    
    
    public function setRight($uid, $rightArray)
    {
        
        if($this->existGrantRight($rightArray)) {
            foreach ($rightArray as $key => $subArray) {
                $field = 'right_' . $key;
                foreach ($subArray as $village => $right) {
                    $this->setUserVillageRight($uid, $village, $field, $right);
                }
            }
        } else {
            $this->deleteUser($uid);
        }
    }
    
    
    private function existUser($uid)
    {
        return $this->database->fetch('SELECT id_user_admin FROM user_admin WHERE id_user_admin = ?', $uid);
    }
    
    
    private function existRightsUser($uid)
    {
        $rights = $this->database->query('SELECT * FROM accessright WHERE id_user_admin = ?', $uid);
        return $rights->getRowCount();
    }
    
    
    private function deleteUser($uid)
    {
        return $this->database->query('DELETE FROM user_admin WHERE id_user_admin = ?', $uid);
    }
    
    
    private function existGrantRight($rightArray)
    {
        $exist = false;
        foreach ($rightArray as $subArray) {
            if(in_array(false, $subArray, true)) {
                $exist = true;
            }
        }
        return $exist;
    }    
    
    private function setUserVillageRight($uid, $village, $field, $right)
    {
        $oldRight = $this->database->fetchField('SELECT ?name FROM accessright '
                . 'WHERE id_user_admin = ? '
                . 'AND id_village = ?', $field, $uid, $village);
        
        if($oldRight === false) {
            $result = $this->database->query('INSERT INTO accessright '
                . '(id_user_admin, id_village, ?name) '
                . 'VALUES '
                . '(?, ?, ?)', $field, $uid, $village, $right);
        } elseif($oldRight !== $right) {
            $result = $this->database->query('UPDATE accessright SET '
                . '?name = ? '
                . 'WHERE id_user_admin = ? '
                . 'AND id_village = ?', $field, $right, $uid, $village);
        }
        return;
    }

}
