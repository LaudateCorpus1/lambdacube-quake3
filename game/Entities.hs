{-# LANGUAGE TemplateHaskell, DeriveGeneric, StandaloneDeriving #-}
module Entities where

import GHC.Generics (Generic)
import Data.Binary

import Data.Map.Strict
import Data.Set
import Data.Vect
import Data.Vect.Float.Util.Quaternion
import Data.Vect.Float.Instances
import Lens.Micro.Platform
import qualified Items

-- entities for game logic

data Player
  = Player
  { _pPosition    :: Vec3
  , _pDirection   :: Vec3
  , _pVelocity    :: Vec3
  , _pRotationUV  :: Vec3
  , _pHealth      :: Int
  , _pArmor       :: Int
  , _pArmorType   :: Maybe Items.Armor
  , _pShootTime   :: Float
  , _pDamageTimer :: Float
  , _pName        :: String
  , _pId          :: Int
  , _pAmmos       :: Map Items.Weapon Int
  , _pWeapons     :: Set Items.Weapon
  , _pSelectedWeapon :: Items.Weapon
  , _pHoldables   :: Map Items.Holdable (Bool, Float)
  , _pPowerups    :: Set Items.Powerup
  , _pCanJump     :: Bool
  } deriving (Eq, Show, Generic)

data Bullet
  = Bullet
  { _bPosition    :: Vec3
  , _bDirection   :: Vec3
  , _bDamage      :: Int
  , _bLifeTime    :: Float
  , _bType        :: Items.Weapon
  } deriving (Eq, Show, Generic)

data Weapon
  = Weapon
  { _wPosition    :: Vec3
  , _wDropped     :: Bool
  , _wType        :: Items.Weapon
  , _wTime        :: Float
  } deriving (Eq, Show, Generic)

data Ammo
  = Ammo
  { _aPosition    :: Vec3
  , _aQuantity    :: Int
  , _aDropped     :: Bool
  , _aType        :: Items.Weapon
  , _aTime        :: Float
  } deriving (Eq, Show, Generic)

data Armor
  = Armor
  { _rPosition    :: Vec3
  , _rQuantity    :: Int
  , _rDropped     :: Bool
  , _rType        :: Items.Armor
  , _rTime        :: Float
  } deriving (Eq, Show, Generic)

data Health
  = Health
  { _hPosition   :: Vec3
  , _hQuantity   :: Int
  , _hType       :: Items.Health
  , _hTime       :: Float
  } deriving (Eq, Show, Generic)

data Spawn
  = Spawn
  { _sSpawnTime :: Float
  , _sEntity    :: Entity
  } deriving (Eq, Show, Generic)

data SpawnPoint
  = SpawnPoint
  { _spPosition :: Vec3
  , _spAngles   :: Vec3
  } deriving (Eq, Show, Generic)

data Lava
  = Lava
  { _lPosition :: Vec3
  , _lDamage   :: Int
  } deriving (Eq, Show, Generic)

data Teleport
  = Teleport
  { _tPosition  :: Vec3
  , _tTarget    :: String
  } deriving (Eq, Show, Generic)

data Target
  = Target
  { _ttPosition   :: Vec3
  , _ttTargetName :: String
  } deriving (Eq, Show, Generic)

data Killbox
  = Killbox
  { _kPosition    :: Vec3
  , _kTargetName  :: String
  } deriving (Eq, Show, Generic)

data Holdable
  = Holdable
  { _hoPosition :: Vec3
  , _hoType     :: Items.Holdable
  , _hoTime     :: Float
  } deriving (Eq, Show, Generic)

data Powerup
  = Powerup
  { _puPosition :: Vec3
  , _puType     :: Items.Powerup
  , _puTime     :: Float
  } deriving (Eq, Show, Generic)

data Entity
  = EPlayer     Player
  | EBullet     Bullet
  | EWeapon     Weapon
  | EAmmo       Ammo
  | EArmor      Armor
  | EHealth     Health
  | ELava       Lava
  | ETeleport   Teleport
  | ETarget     Target
  | EKillbox    Killbox
  | PSpawn      Spawn
  | ESpawnPoint SpawnPoint
  | EHoldable   Holdable
  | EPowerup    Powerup
  deriving (Eq, Show, Generic)
  
isPlayer :: Entity -> Bool
isPlayer (EPlayer _) = True
isPlayer _ = False
  
data Action 
 = Damage Int --damage quantity

concat <$> mapM makeLenses [''Player, ''Bullet, ''Weapon, ''Ammo, ''Armor, ''Spawn, ''Health, ''Lava, ''Teleport, ''Target, ''Killbox, ''Holdable, ''Powerup]

deriving instance Generic Vec3
instance Binary Vec3

instance Binary Player
instance Binary Bullet
instance Binary Weapon
instance Binary Ammo
instance Binary Armor
instance Binary Spawn
instance Binary SpawnPoint
instance Binary Health
instance Binary Lava
instance Binary Teleport
instance Binary Target
instance Binary Killbox
instance Binary Holdable
instance Binary Powerup
instance Binary Entity
