pragma solidity ^0.8.16;

// We must import X as Y so that ILightClient doesn't conflict when we try to import
// both LightClientMock and TargetAMB in the same test file.
import {ILightClientGetter as ILightClientMock} from "src/interfaces/ILightClient.sol";

contract LightClientMock is ILightClientMock {
    bool public consistent = true;
    uint256 public head;
    mapping(uint256 => bytes32) public headers;
    mapping(uint64 => bytes32) public executionStateRoot;
    mapping(uint256 => uint256) public timestamps;

    event HeadUpdate(uint256 indexed slot, bytes32 indexed root);

    function setHeader(uint256 slot, bytes32 headerRoot) external {
        headers[slot] = headerRoot;
        timestamps[slot] = block.timestamp;
        head = slot;
        emit HeadUpdate(slot, headerRoot);
    }

    function setExecutionRoot(uint64 slot, bytes32 executionRoot) external {
        executionStateRoot[slot] = executionRoot;
        timestamps[slot] = block.timestamp;
        head = slot;
        emit HeadUpdate(slot, executionRoot);
    }
}
