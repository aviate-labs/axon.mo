import Result "mo:base/Result";

module {
    public type AccountIdentifier = { hash : [Nat8] };

    public type Action = {
        #ManageNeuron            : ManageNeuron;
        #ExecuteNnsFunction      : ExecuteNnsFunction;
        #RewardNodeProvider      : RewardNodeProvider;
        #SetDefaultFollowees     : SetDefaultFollowees;
        #ManageNetworkEconomics  : NetworkEconomics;
        #ApproveGenesisKyc       : ApproveGenesisKyc;
        #AddOrRemoveNodeProvider : AddOrRemoveNodeProvider;
        #Motion                  : Motion;
    };

    public type AddHotKey = {
        new_hot_key : ?Principal;
    };

    public type AddOrRemoveNodeProvider = {
        change : ?Change;
    };

    public type Amount = {
        e8s : Nat64;
    };

    public type ApproveGenesisKyc = { 
        principals : [Principal] ;
    };

    public type AxonCommand = (AxonCommandRequest, ?AxonCommandResponse);

    public type AxonCommandExecution = {
        #Ok;
        #Transfer : {
            senderBalanceAfter : Nat;
            amount             : Nat;
            receiver           : Principal;
        };
        #SupplyChanged : {
            to   : Nat;
            from : Nat;
        };
    };

    public type AxonCommandRequest = {
        #Redenominate : { 
            to : Nat;
            from : Nat;
        };
        #Mint : {
            recipient : ?Principal;
            amount    : Nat;
        };
        #RemoveMembers : [Principal];
        #AddMembers    : [Principal];
        #Transfer : {
            recipient : Principal;
            amount    : Nat;
        };
        #SetVisibility : Visibility;
        #SetPolicy     : Policy;
    };

    public type AxonCommandResponse = {
        #ok  : AxonCommandExecution;
        #err : Error;
    };

    public type AxonProposal = {
        id         : Nat;
        status     : [Status];
        creator    : Principal;
        ballots    : [ProposalBallot];
        timeStart  : Int;
        totalVotes : Votes;
        proposal   : ProposalType;
        timeEnd    : Int;
        policy     : Policy;
    };

    public type AxonPublic = {
        id           : Nat;
        balance      : Nat;
        name         : Text;
        tokenHolders : Nat;
        totalStake   : Nat;
        supply       : Nat;
        proxy        : Proxy;
        visibility   : Visibility;
        policy       : Policy;
    };

    public type Ballot = {
        vote         : Int32;
        voting_power : Nat64;
    };

    public type BallotInfo = {
        vote        : Int32;
        proposal_id : ?NeuronId;
    };

    public type CanisterStatusResult = {
        status : {
            #stopped;
            #stopping;
            #running;
        };
        memory_size : Nat;
        cycles      : Nat;
        settings    : definite_canister_settings;
        module_hash : ?[Nat8];
    };

    public type Change = {
        #ToRemove : NodeProvider;
        #ToAdd    : NodeProvider;
    };

    public type Command = {
        #Spawn            : Spawn;
        #Split            : Split;
        #Follow           : Follow;
        #Configure        : Configure;
        #RegisterVote     : RegisterVote;
        #DisburseToNeuron : DisburseToNeuron;
        #MakeProposal     : Proposal;
        #Disburse         : Disburse;
    };

    public type CommandResponse = {
        #Error            : GovernanceError;
        #Spawn            : SpawnResponse;
        #Split            : SpawnResponse;
        #Follow           : {};
        #Configure        : {};
        #RegisterVote     : {};
        #DisburseToNeuron : SpawnResponse;
        #MakeProposal     : MakeProposalResponse;
        #Disburse         : DisburseResponse;
    };

    public type Configure = {
        operation : ?Operation;
    };

    public type Disburse = {
        to_account : ?AccountIdentifier;
        amount     : ?Amount;
    };

    public type DisburseResponse = {
        transfer_block_height : Nat64;
    };

    public type DisburseToNeuron = {
        dissolve_delay_seconds : Nat64;
        kyc_verified           : Bool;
        amount_e8s             : Nat64;
        new_controller         : ?Principal;
        nonce                  : Nat64;
    };

    public type DissolveState = {
        #DissolveDelaySeconds          : Nat64;
        #WhenDissolvedTimestampSeconds : Nat64;
    };

    public type Error = {
        #AlreadyVoted;
        #Error : {
            error_message : Text;
            error_type    : ErrorCode;
        };
        #CannotVote;
        #CannotExecute;
        #ProposalNotFound;
        #InvalidProposal;
        #InsufficientBalance;
        #NotFound;
        #Unauthorized;
        #NotProposer;
        #NoNeurons;
        #GovernanceError : GovernanceError;
        #InsufficientBalanceToPropose;
    };

    public type ErrorCode = {
        #canister_error;
        #system_transient;
        #future : Nat32;
        #canister_reject;
        #destination_invalid;
        #system_fatal;
    };

    public type ExecuteNnsFunction = {
        nns_function : Int32;
        payload      : [Nat8];
    };

    public type Follow = {
        topic     : Int32;
        followees : [NeuronId];
    };

    public type Followees = {
        followees : [NeuronId];
    };

    public type GovernanceError = {
        error_message : Text;
        error_type    : Int32;
    };

    public type IncreaseDissolveDelay = {
        additional_dissolve_delay_seconds : Nat32;
    };

    public type Initialization = {
        ledgerEntries : [LedgerEntry];
        name          : Text;
        visibility    : Visibility;
        policy        : Policy;
    };

    public type LedgerEntry = (Principal, Nat);

    public type ListNeuronsResponse = {
        neuron_infos : [(Nat64, NeuronInfo)];
        full_neurons : [Neuron];
    };

    public type MakeProposalResponse = {
        proposal_id : ?NeuronId;
    };

    public type ManageNeuron = {
        id      : ?NeuronId;
        command : ?Command;
    };

    public type ManageNeuronResponse = {
        command : ?CommandResponse;
    };

    public type ManageNeuronResponseOrProposal = {
        #ProposalInfo         : Result.Result<?ProposalInfo, Error>;
        #ManageNeuronResponse : Result.Result<ManageNeuronResponse, Error>;
    };

    public type Motion = {
        motion_text : Text
    };

    public type NetworkEconomics = {
        neuron_minimum_stake_e8s               : Nat64;
        max_proposals_to_keep_per_topic        : Nat32;
        neuron_management_fee_per_proposal_e8s : Nat64;
        reject_cost_e8s                        : Nat64;
        transaction_fee_e8s                    : Nat64;
        neuron_spawn_dissolve_delay_seconds    : Nat64;
        minimum_icp_xdr_rate                   : Nat64;
        maximum_node_provider_rewards_e8s      : Nat64;
    };

    public type Neuron = {
        id                            : ?NeuronId;
        controller                    : ?Principal;
        recent_ballots                : [BallotInfo];
        kyc_verified                  : Bool;
        not_for_profit                : Bool;
        maturity_e8s_equivalent       : Nat64;
        cached_neuron_stake_e8s       : Nat64;
        created_timestamp_seconds     : Nat64;
        aging_since_timestamp_seconds : Nat64;
        hot_keys                      : [Principal];
        account                       : [Nat8];
        dissolve_state                : ?DissolveState;
        followees                     : [(Int32, Followees)];
        neuron_fees_e8s               : Nat64;
        transfer                      : ?NeuronStakeTransfer;
    };

    public type NeuronCommand = (NeuronCommandRequest, ?[NeuronCommandResponse]);

    public type NeuronCommandRequest = {
        command   : Command;
        neuronIds : ?[Nat64];
    };

    public type NeuronCommandResponse = (Nat64, [ManageNeuronResponseOrProposal]);

    public type NeuronId = {
        id : Nat64;
    };

    public type NeuronInfo = {
        dissolve_delay_seconds         : Nat64;
        recent_ballots                 : [BallotInfo];
        created_timestamp_seconds      : Nat64;
        state                          : Int32;
        retrieved_at_timestamp_seconds : Nat64;
        voting_power                   : Nat64;
        age_seconds                    : Nat64;
    };

    public type NeuronStakeTransfer = {
        to_subaccount      : [Nat8];
        neuron_stake_e8s   : Nat64;
        from               : ?Principal;
        memo               : Nat64;
        from_subaccount    : [Nat8];
        transfer_timestamp : Nat64;
        block_height       : Nat64;
    };

    public type Neurons = {
        response  : ListNeuronsResponse;
        timestamp : Int;
    };

    public type NeuronsResult = {
        #ok  : Neurons;
        #err : Error;
    };

    public type NewProposal = {
        axonId          : Nat;
        timeStart       : ?Int;
        durationSeconds : ?Nat;
        proposal        : ProposalType;
        execute         : ?Bool;
    };

    public type NodeProvider = {
        id : ?Principal;
    };

    public type Operation = {
        #RemoveHotKey          : RemoveHotKey;
        #AddHotKey             : AddHotKey;
        #StopDissolving        : {};
        #StartDissolving       : {};
        #IncreaseDissolveDelay : IncreaseDissolveDelay;
        #SetDissolveTimestamp  : SetDissolveTimestamp;
    };

    public type Policy = {
        proposeThreshold    : Nat;
        proposers : {
            #Open;
            #Closed : [Principal];
        };
        acceptanceThreshold : Threshold;
    };

    public type Proposal = {
        url     : Text;
        action  : ?Action;
        summary : Text;
    };

    public type ProposalBallot = {
        principal   : Principal;
        votingPower : Nat;
        vote        : ?Vote;
    };

    public type ProposalInfo = {
        id                         : ?NeuronId;
        status                     : Int32;
        topic                      : Int32;
        failure_reason             : ?GovernanceError;
        ballots                    : [(Nat64, Ballot)];
        proposal_timestamp_seconds : Nat64;
        reward_event_round         : Nat64;
        failed_timestamp_seconds   : Nat64;
        reject_cost_e8s            : Nat64;
        latest_tally               : ?Tally;
        reward_status              : Int32;
        decided_timestamp_seconds  : Nat64;
        proposal                   : ?Proposal;
        proposer                   : ?NeuronId;
        executed_timestamp_seconds : Nat64;
    };

    public type ProposalResult = {
        #ok  : [AxonProposal];
        #err : Error;
    };

    public type ProposalType = {
        #NeuronCommand : NeuronCommand;
        #AxonCommand   : AxonCommand;
    };

    public type Proxy = actor {
        list_neurons  : shared ()           -> async ListNeuronsResponse;
        manage_neuron : shared ManageNeuron -> async ManageNeuronResponse;
    };

    public type RegisterVote = {
        vote     : Int32;
        proposal : ?NeuronId;
    };

    public type RemoveHotKey = {
        hot_key_to_remove : ?Principal;
    };

    public type RewardMode = {
        #RewardToNeuron  : RewardToNeuron;
        #RewardToAccount : RewardToAccount;
    };

    public type RewardNodeProvider = {
        node_provider : ?NodeProvider;
        reward_mode   : ?RewardMode;
        amount_e8s    : Nat64;
    };

    public type RewardToAccount = {
        to_account : ?AccountIdentifier;
    };

    public type RewardToNeuron = {
        dissolve_delay_seconds : Nat64;
    };

    public type SetDefaultFollowees = {
        default_followees : [(Int32, Followees)];
    };

    public type SetDissolveTimestamp = {
        dissolve_timestamp_seconds : Nat64;
    };

    public type Spawn = {
        new_controller : ?Principal;
    };

    public type SpawnResponse = {
        created_neuron_id : ?NeuronId;
    };

    public type Split = {
        amount_e8s : Nat64;
    };

    public type Status = {
        #ExecutionTimedOut : Int;
        #Active            : Int;
        #Rejected          : Int;
        #ExecutionQueued   : Int;
        #Accepted          : Int;
        #ExecutionStarted  : Int;
        #ExecutionFinished : Int;
        #Cancelled         : Int;
        #Created           : Int;
        #Expired           : Int;
    };

    public type Tally = {
      no                : Nat64;
      yes               : Nat64;
      total             : Nat64;
      timestamp_seconds : Nat64;
    };

    public type Threshold = {
        #Percent : {
            percent : Nat;
            quorum  : ?Nat;
        };
        #Absolute : Nat;
    };

    public type Visibility = {
        #Private;
        #Public;
    };

    public type Vote = {
        #No;
        #Yes;
    };

    public type VoteRequest = {
        axonId     : Nat;
        vote       : Vote;
        proposalId : Nat;
    };

    public type Votes = {
        no  : Nat;
        yes : Nat;
        notVoted : Nat;
    };

    public type definite_canister_settings = {
        freezing_threshold : Nat;
        controllers        : [Principal];
        memory_allocation  : Nat;
        compute_allocation : Nat;
    };

    public type Interface = actor {
        axonById           : query  Nat                   -> async AxonPublic;
        axonStatusById     : shared Nat                   -> async CanisterStatusResult;
        balanceOf          : query (Nat, ?Principal)      -> async Nat;
        cancel             : shared (Nat, Nat)            -> async Result.Result<AxonProposal, Error>;
        cleanup            : shared Nat                   -> async Result.Result<(), Error>;
        count              : query ()                     -> async Nat;
        create             : shared Initialization        -> async Result.Result<AxonPublic, Error>;
        execute            : shared (Nat, Nat)            -> async Result.Result<AxonProposal, Error>;
        getActiveProposals : query Nat                    -> async ProposalResult;
        getAllProposals    : query (Nat, ?Nat)            -> async ProposalResult;
        getNeuronIds       : query Nat                    -> async [Nat64];
        getNeurons         : query Nat                    -> async NeuronsResult;
        getProposalById    : query (Nat, Nat)             -> async Result.Result<AxonProposal, Error>;
        ledger             : query Nat                    -> async [LedgerEntry];
        myAxons            : query ()                     -> async [AxonPublic];
        propose            : shared NewProposal           -> async Result.Result<AxonProposal, Error>;
        sync               : shared Nat                   -> async NeuronsResult;
        topAxons           : query ()                     -> async [AxonPublic];
        transfer           : shared (Nat, Principal, Nat) -> async Result.Result<(), Error>;
        vote               : shared VoteRequest           -> async Result.Result<(), Error>;
        wallet_receive     : shared ()                    -> async Nat;
    }
}
