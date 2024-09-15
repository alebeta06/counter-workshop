#[starknet::interface]
trait Icounter<T> {
    fn get_counter(self: @T) -> u32;
    fn increase_counter(ref self: T);
}

#[starknet::contract]
pub mod counter {
    use starknet::ContractAddress;

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
   fn constructor(ref self: ContractState, value: u32) {
      self.counter.write(value);
   }

   #[abi(embed_v0)]
   impl IcounterImpl of super::Icounter<ContractState> {
       fn get_counter(self: @ContractState) -> u32 {
          self.counter.read()
        }

       fn increase_counter(ref self: ContractState) {
           let old_val = self.counter.read();
           self.counter.write(old_val + 1);
           self.emit(CounterIncreased { counter: old_val + 1 });
        }
    }  
}