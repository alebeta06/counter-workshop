use super::utils::{deploy_contract};
use kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait};

#[test]
fn test_kill_switch(){
    let contract_address = deploy_contract(true);
    let dispatcher = IKillSwitchDispatcher {contract_address};

    assert!(dispatcher.is_active() == true, "Stored value not equal");
}