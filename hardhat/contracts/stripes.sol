// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.4;

  import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
  import "@openzeppelin/contracts/access/Ownable.sol";
  import "@openzeppelin/contracts/utils/Strings.sol";


  contract stripes is ERC721Enumerable, Ownable {
      using Strings for uint256;
      string _baseTokenURI = "ipfs://QmXGb4nTxsJU13bmhdAmoVND9A6NwnsNP4UB3gN4r5yd8K/";
      string baseExtension = ".json";
      uint256 public _price = 0.01 ether;
      bool public _paused;
      uint256 public maxTokenIds = 31;
      uint256 public tokenIds;
      
      modifier onlyWhenNotPaused {
          require(!_paused, "Contract currently paused");
          _;
      }

      constructor () ERC721("Stripes", "stripes") {}

      function mint(uint id) public payable onlyWhenNotPaused {
          require(tokenIds < maxTokenIds, "Exceed maximum Crypto Devs supply");
          require(msg.value >= _price, "Ether sent is not correct");
          tokenIds += 1;
          address _owner = owner();
          (bool sent, ) =  _owner.call{value: msg.value}("");
          require(sent, "Failed to send Ether");
          _safeMint(msg.sender, id);
      }

      function _baseURI() internal view virtual override returns (string memory) {
          return _baseTokenURI;
      }

      function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString(),baseExtension)) : "";
    }

      function setPaused(bool val) public onlyOwner {
          _paused = val;
      }

      receive() external payable {}
      fallback() external payable {}
  }