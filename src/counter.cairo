#[starknet::interface]
trait Icounter<T> {
    fn get_counter(self: @T) -> u32;
    fn increase_counter(ref self: T);
}

#[starknet::contract]
pub mod counter {
    #[storage]
    struct Storage {
        counter: u32,
    }
    
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        #[key]
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

       fn increase_counter(ref self: ContractState) {
           self.counter.write(self.counter.read() + 1);
           self.emit(CounterIncreased{counter: self.counter.read()});
        }
    }  
}