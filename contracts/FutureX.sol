// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FutureCertX is ERC721, ERC721URIStorage, Ownable {
    uint256 public _nextTokenId;
    uint256 public mintPrice; // Price to mint a token
  //  string[] public mintedCerts; //
    mapping(address => uint256) private _tokenCounts;
    // Mapping to store the token URIs of each token ID
    mapping(uint256 => string) public tokenURIs;
    // Mapping to track the tokens owned by each address
    mapping(address => uint256[]) public ownedTokens;

    constructor(address initialOwner)
        ERC721("FutureCertX", "FCX")
        Ownable(initialOwner)
    {
        mintPrice = 0.0001 ether; // Set the initial mint price
    }
   

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs/QmduF7btRtwNm8fecdjv6ahbPcZdZcRNBbGrMWRazVJPJC/";
    }
   function getOwnedTokens(address owner) public view returns (uint256[] memory) {
    return ownedTokens[owner];
   }
   function getTokenCount(address owner) public view returns (uint256) {
    return _tokenCounts[owner];
   }

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
          _addTokenToOwner(to, tokenId);
        _setTokenURI(tokenId, uri);
      
    }

    function setMintPrice(uint256 price) external onlyOwner {
        mintPrice = price;
    }

    function payToMint(address recipient,string memory metadataURI) public payable returns (uint256) {
      //  require(existingURIs[metadataURI] != 1, 'NFT already minted!');
        require (msg.value >= mintPrice, 'Insufficient credits to certfy!');
        uint256 newItemId = _nextTokenId;
        _nextTokenId++;
       
       _mint(recipient, newItemId);
        _setTokenURI( newItemId,metadataURI);
        _tokenCounts[recipient]++; // Increase the token count for the recipient
       _addTokenToOwner(recipient, newItemId);
        return newItemId;

        
    }

    function balanceOf(address owner) override(ERC721,IERC721) public view returns (uint256) {
        return _tokenCounts[owner];
    }

    // The following functions are overrides required by Solidity.

    // function tokenURI(uint256 tokenId)
    //     public
    //     view
    //     override(ERC721, ERC721URIStorage)
    //     returns (string memory)
    // {
    //     return super.tokenURI(tokenId);
    // }
    function tokenURI(uint256 tokenId) 
    public 
    view
    virtual 
    override(ERC721,ERC721URIStorage)
     returns (string memory) {
    //require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    string memory baseURI = _baseURI();
    return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, Strings.toString(tokenId), ".json")) : "";
}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function tokensURIsOfOwner(address owner) public view returns (string[] memory) {
 

    uint256[] memory ownerTokens = ownedTokens[owner];
        uint256 tokenCount = ownerTokens.length;
        string[] memory certs = new string[](tokenCount);
        if(tokenCount != 0){
        for (uint256 i = 0; i < tokenCount; i++){
            uint256 tokenId = ownerTokens[i];
            certs[i] = tokenURI(tokenId);
        }
       return certs;}
       else{
        return new string[](0);
       }
        
      
        }




    

    function getTokenURI(uint256 tokenId) public view returns (string memory) {
       
        return tokenURI(tokenId);
    }

    // Function to add a token to the owner's list of tokens
    function _addTokenToOwner(address owner, uint256 tokenId) internal {
        ownedTokens[owner].push(tokenId);
    }

}