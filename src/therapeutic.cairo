use starknet::ContractAddress;


#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, x: AnonUser);
    fn get(self: @TContractState) -> AnonUser;
}



#[derive(Copy, Drop, Serde, starknet::Store)]
struct AnonUser {
    active: bool,
    username: felt252,
    mental_category: felt252,
    region: felt252,
}



#[starknet::contract]
mod SimpleStorage {
    use starknet::get_caller_address;
    use starknet::ContractAddress;
    use therapeutic::therapeutic::AnonUser;

    #[storage]
    struct Storage {
        anonUser: AnonUser
    }
    
    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
      fn set(ref self: ContractState, x: AnonUser) {
            self.anonUser.write(x);
        }
        fn get(self: @ContractState) -> AnonUser {
            self.anonUser.read()
        }
    }

}


