// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GLD is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // 初始化代币名称和符号
    }

    /**
     * @dev 从签名中恢复签名者地址
     * @param messageHash 消息的哈希值
     * @param r 签名的 r 值
     * @param s 签名的 s 值
     * @param v 签名的 v 值
     * @return 签名者的地址
     */
    function recoverSigner(
        bytes32 messageHash,
        bytes32 r,
        bytes32 s,
        uint8 v
    ) public pure returns (address) {
        // 确保 v 值是 27 或 28
        require(v == 27 || v == 28, "Invalid v value");

        // 使用 ecrecover 恢复签名者地址
        address signer = ecrecover(messageHash, v, r, s);
        require(signer != address(0), "Invalid signature");

        return signer;
    }

    /**
     * @dev 将消息哈希和签名拆分为 r, s, v
     * @param messageHash 消息的哈希值
     * @param signature 签名（65 字节）
     * @return r 签名的 r 值
     * @return s 签名的 s 值
     * @return v 签名的 v 值
     */
    function splitSignature(bytes32 messageHash, bytes memory signature)
        public
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        // 确保签名长度为 65 字节
        require(signature.length == 65, "Invalid signature length");

        // 拆分签名
        assembly {
            r := mload(add(signature, 32))
            s := mload(add(signature, 64))
            v := byte(0, mload(add(signature, 96)))
        }

        // 如果 v 是 0 或 1，调整为 27 或 28
        if (v < 27) {
            v += 27;
        } 

        return (r, s, v);
    }

    /**
     * @dev 从消息哈希和签名中恢复签名者地址
     * @param messageHash 消息的哈希值
     * @param signature 签名（65 字节）
     * @return 签名者的地址
     */
    function recoverSignerFromSignature(bytes32 messageHash, bytes memory signature)
        public
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(messageHash, signature);
        return recoverSigner(messageHash, r, s, v);
    }
} 