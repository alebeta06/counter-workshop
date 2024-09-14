#[starknet::interface]
trait Icounter<T> {
    fn get_counter(self: @T) -> u32;
}

#[starknet::contract]
pub mod counter {
    #[storage]
    struct Storage {
        counter: u32,
    }


   #[constructor]
   fn constructor(ref self: ContractState, input: u32) {
      self.counter.write(input);
   }

   #[abi(embed_v0)]
   impl IcounterImpl of super::Icounter<ContractState> {
    fn get_counter(self: @ContractState) -> u32 {
        self.counter.read()
    }
   }  
}