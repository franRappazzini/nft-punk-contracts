// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract NFTPunkDNA {
    string[] private accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];

    function pseudoRandomDNA(uint256 _tokenId, address _minter)
        public
        pure
        returns (uint256)
    {
        uint256 combinedParams = _tokenId + uint160(_minter);
        bytes memory encodedParams = abi.encodePacked(combinedParams);
        bytes32 hashedParams = keccak256(encodedParams);

        return uint256(hashedParams);
    }

    uint8 constant DNA_SECTION_SIZE = 2;

    function _getDNASection(uint256 _dna, uint8 _rightDiscard)
        internal
        pure
        returns (uint8)
    {
        return
            uint8(
                (_dna % (1 * 10**(_rightDiscard + DNA_SECTION_SIZE))) /
                    (1 * 10**_rightDiscard)
            );
    }

    function getAccesoriesType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint8 dnaSection = _getDNASection(_dna, 0);
        return accessoriesType[dnaSection % accessoriesType.length];
    }

    function getClotheColor(uint256 _dna) public view returns (string memory) {
        uint8 dnaSection = _getDNASection(_dna, 2);
        return clotheColor[dnaSection % clotheColor.length];
    }

    function getClotheType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 4);
        return clotheType[dnaSection % clotheType.length];
    }

    function getEyeType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 6);
        return eyeType[dnaSection % eyeType.length];
    }

    function getEyeBrowType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 8);
        return eyebrowType[dnaSection % eyebrowType.length];
    }

    function getFacialHairColor(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = _getDNASection(_dna, 10);
        return facialHairColor[dnaSection % facialHairColor.length];
    }

    function getFacialHairType(uint256 _dna)
        public
        view
        returns (string memory)
    {
        uint256 dnaSection = _getDNASection(_dna, 12);
        return facialHairType[dnaSection % facialHairType.length];
    }

    function getHairColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 14);
        return hairColor[dnaSection % hairColor.length];
    }

    function getHatColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 16);
        return hatColor[dnaSection % hatColor.length];
    }

    function getGraphicType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 18);
        return graphicType[dnaSection % graphicType.length];
    }

    function getMouthType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 20);
        return mouthType[dnaSection % mouthType.length];
    }

    function getSkinColor(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 22);
        return skinColor[dnaSection % skinColor.length];
    }

    function getTopType(uint256 _dna) public view returns (string memory) {
        uint256 dnaSection = _getDNASection(_dna, 24);
        return topType[dnaSection % topType.length];
    }
}
