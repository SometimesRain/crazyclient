package kabam.rotmg.constants {
public class ItemConstants {

    public static const NO_ITEM:int = -1;
    public static const ALL_TYPE:int = 0;
    public static const SWORD_TYPE:int = 1;
    public static const DAGGER_TYPE:int = 2;
    public static const BOW_TYPE:int = 3;
    public static const TOME_TYPE:int = 4;
    public static const SHIELD_TYPE:int = 5;
    public static const LEATHER_TYPE:int = 6;
    public static const PLATE_TYPE:int = 7;
    public static const WAND_TYPE:int = 8;
    public static const RING_TYPE:int = 9;
    public static const POTION_TYPE:int = 10;
    public static const SPELL_TYPE:int = 11;
    public static const SEAL_TYPE:int = 12;
    public static const CLOAK_TYPE:int = 13;
    public static const ROBE_TYPE:int = 14;
    public static const QUIVER_TYPE:int = 15;
    public static const HELM_TYPE:int = 16;
    public static const STAFF_TYPE:int = 17;
    public static const POISON_TYPE:int = 18;
    public static const SKULL_TYPE:int = 19;
    public static const TRAP_TYPE:int = 20;
    public static const ORB_TYPE:int = 21;
    public static const PRISM_TYPE:int = 22;
    public static const SCEPTER_TYPE:int = 23;
    public static const KATANA_TYPE:int = 24;
    public static const SHURIKEN_TYPE:int = 25;
    public static const EGG_TYPE:int = 26;


    public static function itemTypeToName(_arg_1:int):String {
        switch (_arg_1) {
            case ALL_TYPE:
                return ("EquipmentType.Any");
            case SWORD_TYPE:
                return ("EquipmentType.Sword");
            case DAGGER_TYPE:
                return ("EquipmentType.Dagger");
            case BOW_TYPE:
                return ("EquipmentType.Bow");
            case TOME_TYPE:
                return ("EquipmentType.Tome");
            case SHIELD_TYPE:
                return ("EquipmentType.Shield");
            case LEATHER_TYPE:
                return ("EquipmentType.LeatherArmor");
            case PLATE_TYPE:
                return ("EquipmentType.Armor");
            case WAND_TYPE:
                return ("EquipmentType.Wand");
            case RING_TYPE:
                return ("EquipmentType.Accessory");
            case POTION_TYPE:
                return ("EquipmentType.Potion");
            case SPELL_TYPE:
                return ("EquipmentType.Spell");
            case SEAL_TYPE:
                return ("EquipmentType.HolySeal");
            case CLOAK_TYPE:
                return ("EquipmentType.Cloak");
            case ROBE_TYPE:
                return ("EquipmentType.Robe");
            case QUIVER_TYPE:
                return ("EquipmentType.Quiver");
            case HELM_TYPE:
                return ("EquipmentType.Helm");
            case STAFF_TYPE:
                return ("EquipmentType.Staff");
            case POISON_TYPE:
                return ("EquipmentType.Poison");
            case SKULL_TYPE:
                return ("EquipmentType.Skull");
            case TRAP_TYPE:
                return ("EquipmentType.Trap");
            case ORB_TYPE:
                return ("EquipmentType.Orb");
            case PRISM_TYPE:
                return ("EquipmentType.Prism");
            case SCEPTER_TYPE:
                return ("EquipmentType.Scepter");
            case KATANA_TYPE:
                return ("EquipmentType.Katana");
            case SHURIKEN_TYPE:
                return ("EquipmentType.Shuriken");
            case EGG_TYPE:
                return ("EquipmentType.Any");
        }
        return ("EquipmentType.InvalidType");
    }


}
}//package kabam.rotmg.constants
