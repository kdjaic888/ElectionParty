pragma solidity ^0.5.0;


contract Election {

	struct Candidate{
		uint id;
		string ime;
    string vrsta;
		uint brojacGlasova;
	}	
    
  mapping(address => bool) public biraci;
	mapping(uint => Candidate)public candidates;
	uint public candidatesCount;

  event glasDogadjaj(
  	uint indexed _candidateId
  	);

  constructor() public {
  	dodajStranku("HDZ", "Hrvatska demokratska zajednica");
  	dodajStranku("SDP", "Socijaldemokratska partija Hrvatske");
    dodajStranku("Zivi zid", "Zivi zid");
    dodajStranku("IDS", "Istarski demokratski sabor");
    dodajStranku("Glas", "Glas");
  }

  function dodajStranku (string memory _ime, string memory _vrsta)private {
  	candidatesCount ++;
  	candidates[candidatesCount] = Candidate(candidatesCount, _ime, _vrsta, 0);
  	}

  function glas (uint _candidateId)public{
  	require(!biraci[msg.sender]);
  	require(_candidateId > 0 && _candidateId <= candidatesCount);
  	biraci[msg.sender] = true;
  	candidates[_candidateId].brojacGlasova ++;
  	emit glasDogadjaj(_candidateId);
  	}
}

