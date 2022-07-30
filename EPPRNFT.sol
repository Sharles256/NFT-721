// EPPR - NFT 721 para OpenSea en Polygon: https://github.com/EPPR/NFT-721/
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;
// https://github.com/EPPR/NFT-721/blob/main/EPPRNFT.sol (Link para importar en Remix)
// Link de Remix: https://remix.ethereum.org/
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EPPRNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    

    constructor() ERC721("EPPR NFT", "MI PRIMER NFT") {
    //Aquí se define quien es el dueño del contrato
    contractOwner = msg.sender;
    }

    address contractOwner;
    //Tarea 1 en esta variable address el contrato se entera quien es su papi

//function totalSupply() public view returns(uint256){ return _tokenIds;      }

    event Mint(
        address indexed sender,
        address indexed owner,
        string tokenURI,
        uint256 tokenId
    );

    function mint(address owner, string memory tokenURI)
        public
        returns (uint256)
    {
        if(_address != msg.sender){
        require( 
            msg.sender == contractOwner, 
            "Only contract owner can AIRDROP NFT"
        );
//Tarea 2 Permitir hacer AIRDROPS  

        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(owner, newItemId);
        _setTokenURI(newItemId, tokenURI);

        emit Mint(msg.sender, owner, tokenURI, newItemId);
        return newItemId;
    }

    //Tarea 3 crear función para poder modificar el Json y que solo el dueño del contrato lo pueda hacer
    function setUri(uint256 _tokenId, string memory  _URI) external {
        require(
            msg.sender == contractOwner,
            "Only contract owner can change TokenId or URI"
            );
         _setTokenURI(_tokenId, _URI);
}

    function uri(uint256 tokenId) public view returns (string memory) {
        return tokenURI(tokenId);
    }
}
