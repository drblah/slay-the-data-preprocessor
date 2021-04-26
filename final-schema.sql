 
create table event
(
    floor_reached         integer,
    playtime              integer,
    score                 integer,
    play_id               text,
    local_time            text,
    is_ascension_mode     boolean,
    neow_cost             text,
    seed_source_timestamp numeric,
    circlet_count         integer,
    seed_played           text,
    is_trial              boolean,
    character_chosen      text,
    campfire_rested       integer,
    gold                  integer,
    neow_bonus            text,
    is_prod               boolean,
    is_daily              boolean,
    chose_seed            boolean,
    campfire_upgraded     integer,
    win_rate              numeric,
    timestamp             numeric,
    build_version         text,
    purchased_purges      integer,
    victory               boolean,
    player_experience     numeric,
    is_beta               boolean,
    is_endless            boolean,
    killed_by             text,
    ascension_level       integer,
    special_seed          numeric,
    neow_cos3             text,
    idx                   bigint not null
        constraint event_pkey
            primary key
);

alter table event
    owner to postgres;

create table boss_relics
(
    not_picked text[],
    picked     text,
    idx        bigint not null
        constraint boss_relics_idx_fkey
            references event
            on delete cascade
);

alter table boss_relics
    owner to postgres;

create table campfire_choices
(
    data  text,
    floor integer,
    key   text,
    idx   bigint not null
        constraint campfire_choices_idx_fkey
            references event
            on delete cascade
);

alter table campfire_choices
    owner to postgres;

create table card_choices
(
    not_picked text[],
    picked     text,
    floor      integer,
    idx        bigint not null
        constraint card_choices_idx_fkey
            references event
            on delete cascade
);

alter table card_choices
    owner to postgres;

create table current_hp_per_floor
(
    current_hp_per_floor integer,
    idx                  bigint
        constraint current_hp_per_floor_idx_fkey
            references event
            on delete cascade
);

alter table current_hp_per_floor
    owner to postgres;

create table daily_mods
(
    daily_mods text,
    idx        bigint
        constraint daily_mods_idx_fkey
            references event
            on delete cascade
);

alter table daily_mods
    owner to postgres;

create table damage_taken
(
    damage  integer,
    enemies text,
    floor   integer,
    turns   integer,
    idx     bigint not null
        constraint damage_taken_idx_fkey
            references event
            on delete cascade
);

alter table damage_taken
    owner to postgres;

create table event_choices
(
    damage_healed     integer,
    gold_gain         integer,
    player_choice     text,
    damage_taken      integer,
    relics_obtained   text[],
    max_hp_gain       integer,
    max_hp_loss       integer,
    event_name        text,
    floor             integer,
    gold_loss         integer,
    cards_upgraded    text[],
    cards_removed     text[],
    cards_transformed text[],
    cards_obtained    text[],
    relics_lost       text[],
    potions_obtained  text[],
    idx               bigint not null
        constraint event_choices_idx_fkey
            references event
            on delete cascade
);

alter table event_choices
    owner to postgres;

create table gold_per_floor
(
    gold_per_floor integer,
    idx            bigint
);

alter table gold_per_floor
    owner to postgres;

create table item_purchase_floors
(
    item_purchase_floors integer,
    idx                  bigint
);

alter table item_purchase_floors
    owner to postgres;

create table items_purchased
(
    items_purchased text,
    idx             bigint
);

alter table items_purchased
    owner to postgres;

create table items_purged
(
    items_purged text,
    idx          bigint
);

alter table items_purged
    owner to postgres;

create table items_purged_floors
(
    items_purged_floors integer,
    idx                 bigint
);

alter table items_purged_floors
    owner to postgres;

create table master_deck
(
    master_deck text,
    idx         bigint
);

alter table master_deck
    owner to postgres;

create table max_hp_per_floor
(
    max_hp_per_floor integer,
    idx              bigint
);

alter table max_hp_per_floor
    owner to postgres;

create table path_per_floor
(
    path_per_floor text,
    idx            bigint
);

alter table path_per_floor
    owner to postgres;

create table path_taken
(
    path_taken text,
    idx        bigint
);

alter table path_taken
    owner to postgres;

create table potions_floor_spawned
(
    potions_floor_spawned integer,
    idx                   bigint
);

alter table potions_floor_spawned
    owner to postgres;

create table potions_floor_usage
(
    potions_floor_usage integer,
    idx                 bigint
);

alter table potions_floor_usage
    owner to postgres;

create table potions_obtained
(
    floor integer,
    key   text,
    idx   bigint not null
        constraint potions_obtained_idx_fkey
            references event
            on delete cascade
);

alter table potions_obtained
    owner to postgres;

create table relics
(
    relics text,
    idx    bigint
        constraint relics_idx_fkey
            references event
            on delete cascade
);

alter table relics
    owner to postgres;

create table relics_obtained
(
    floor integer,
    key   text,
    idx   bigint not null
        constraint relics_obtained_idx_fkey
            references event
            on delete cascade
);

alter table relics_obtained
    owner to postgres;

