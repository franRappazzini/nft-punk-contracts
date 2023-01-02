// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./NFTPunkDNA.sol";

contract NFTPunk is ERC721Enumerable, NFTPunkDNA {
    using Counters for Counters.Counter;
    using Strings for uint256;

    Counters.Counter private tokenId;
    uint256 public maxSupply;
    mapping(uint256 => uint256) tokenDNA;

    constructor(uint256 _maxSupply) ERC721("NFT Punk", "NFTP") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 currentId = tokenId.current();
        require(currentId < maxSupply, "No NFT Punks left...");

        tokenDNA[currentId] = pseudoRandomDNA(currentId, msg.sender);

        _safeMint(msg.sender, currentId);
        tokenId.increment();
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://avataaars.io/";
    }

    function paramsURI(uint256 _dna) internal view returns (string memory) {
        string memory params;

        {
            params = string(
                abi.encodePacked(
                    "accesoriesType=",
                    getAccesoriesType(_dna),
                    "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                    getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyeBrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna)
                )
            );
        }

        return string(abi.encodePacked(params, "&topType=", getTopType(_dna)));
    }

    function imageByDNA(uint256 _dna) public view returns (string memory) {
        return string(abi.encodePacked(_baseURI(), "?", paramsURI(_dna)));
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(_tokenId),
            "ERC721 Metadata: URI query for nonexitent token"
        );

        uint256 dna = tokenDNA[_tokenId];
        string memory image = imageByDNA(dna);

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{"name": "NFT Punk #',
                _tokenId.toString(),
                '", "description": "NFT Punk is a collection of 999 unique avatars generated and stored on chain. Stats, images, and other functionality are intentionally omitted for others to interpret. Feel free to use NFT Punk in any way you want.", "image": "',
                image,
                '"}'
            )
        );

        return
            string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }
}
