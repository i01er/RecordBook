pragma solidity ^0.5.2;

contract RecordBook
{
	address public Owner;
	mapping(address => Record) public MyRecord;
	uint public auctionEnd;
	uint public counter;

	event ShowRecord(uint count);
	event ShowMyRecord(string _Name, uint _Record);
	
	struct Record
	{
		string	UintProject;
		string	UnitName;
		uint	UnitRecord;
		bool 	CanUpload;
	}

	function StartApp(uint DurationMinutes) public
	{
		Owner = msg.sender;
		auctionEnd = now + (DurationMinutes * 1 minutes);
		counter = 0;
	}

	function Authorize(address User) public
	{
		require(msg.sender == Owner);
		//require(Record[User].CanUpload == true);

		MyRecord[User].CanUpload = true;
	}

	function Add(string memory Project, string memory Company, uint ID) public
	{
		require(now < auctionEnd);
		require(MyRecord[msg.sender].CanUpload);
	    	
		counter += 1;
		MyRecord[msg.sender].UnitProject = Project;
		MyRecord[msg.sender].UnitName = Company;
		MyRecord[msg.sender].UnitRecord = ID;

		MyRecord[msg.sender].CanUpload = false;
		emit ShowRecord(counter);
	}
	
	function Show() public
	{
	    emit ShowMyRecord(MyRecord[msg.sender].UnitProject, MyRecord[msg.sender].UnitName, MyRecord[msg.sender].UnitRecord);
	}

	function EndApp() public
	{
		require(msg.sender == Owner);

		auctionEnd = now;
	}
}
