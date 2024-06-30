# Degen-Token

<h2>Overview</h2>

The DegenToken is an ERC-20-like token named "Degen" with the symbol "DGN". This smart contract includes functionalities for minting, transferring, redeeming, and burning tokens. It allows the owner to mint new tokens and users to transfer, redeem, and burn tokens as per their requirements.

<h2>Features</h2>

**Minting:** Only the owner can mint new tokens.

**Transferring:** Users can transfer tokens to other addresses.

**Redeeming:** Users can redeem tokens, which reduces their balance and total supply.

**Burning:** Users can burn their tokens, reducing the total supply.

**Allowance:** Users can approve other addresses to spend tokens on their behalf.

<h2>Contract Details</h2>

**Name:** Degen

**Symbol:** DGN

**Decimals:** 18

<h2>State Variables</h2>

**name:** The name of the token.

**symbol:** The symbol of the token.

**decimals:** The number of decimal places the token uses (i.e. 18 in our case).

**totalSupply:** The total supply of the tokens.

**owner:** The address of the contract owner, who has special privileges.

**balances:** A mapping that tracks the balance of each address.

**allowances:** A mapping that tracks the allowances set by token holders for other addresses.

**redeemedTokens:** A mapping that tracks the amount of tokens each address has redeemed.

<h2>Events</h2>

**Transfer:** Emitted when tokens are transferred.

**Approval:** Emitted when an allowance is set.

**Mint:** Emitted when new tokens are minted.

**Redeem:** Emitted when tokens are redeemed.

**Burn:** Emitted when tokens are burned.

<h2>Modifiers</h2>

**onlyOwner:** This modifier restricts the execution of certain functions to the contract owner.

<h2>Functions</h2>

<h3>Minting</h3>

**mint(address to, uint256 amount):**

Only the owner can call this function.

Mints new tokens and assigns them to the specified address.

Increases the totalSupply and updates the balance of the recipient.

Emits the Mint and Transfer events.

<h3>Redeeming</h3>

**redeem(uint256 amount):**

Allows any token holder to redeem (remove from circulation) their tokens.

Decreases the balance of the sender and increases their redeemedTokens.

Internally calls _burn to handle the burning of tokens.

Emits the Redeem event.

**redeemedTokensOf(address account):**

Returns the number of tokens redeemed by a specific address.

<h3>Burning</h3>

**burn(uint256 amount):**

Allows any token holder to burn their tokens.

Calls the internal _burn function.

**_burn(address account, uint256 amount):**

An internal function that handles the burning of tokens.

Ensures the account burning the tokens has a sufficient balance.

Decreases the totalSupply and the balance of the account.

Emits the Burn and Transfer events.

<h3>Transferring</h3>

**transfer(address recipient, uint256 amount):**

Allows a token holder to transfer tokens to another address.

Calls the internal _transfer function.

**_transfer(address sender, address recipient, uint256 amount):**

An internal function that handles the transfer of tokens.

Ensures the sender has a sufficient balance, considering the redeemed tokens.

Updates the balances of the sender and recipient.

Emits the Transfer event.

<h3>Balances and Allowances</h3>

**balanceOf(address account):**

Returns the token balance of a specific address.

**approve(address spender, uint256 amount):**

Allows a token holder to approve another address to spend a specified amount of tokens on their behalf.

Updates the allowances mapping and emits the Approval event.

**allowance(address tokenOwner, address spender):**

Returns the remaining number of tokens that the spender is allowed to spend from the owner's account.

**transferFrom(address sender, address recipient, uint256 amount):**

Allows an approved address to transfer tokens from one address to another.

Ensures the spender has enough allowance.

Updates the allowances and calls the internal _transfer function.

<h2>Usage</h2>

**Deploying the Contract**

Deploy the DegenToken contract to the Ethereum blockchain. The deployer will be the owner.

**Minting Tokens**

As the owner, mint tokens to an address.

**Transferring Tokens**

Transfer tokens from one address to another.

**Redeeming Tokens**

Redeem tokens from the balance.

**Checking Balances and Redeemed Tokens**

Check the balance of an address.

Check the redeemed tokens of an address.

**Burning Tokens**

Burn tokens from the balance.

<h2>License</h2>

This project is licensed under the **MIT** License
