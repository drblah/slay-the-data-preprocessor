CREATE TABLE event(
	floor_reached numeric,
	playtime numeric,
	score numeric,
	play_id text,
	local_time text,
	is_ascension_mode bool,
	neow_cost text,
	seed_source_timestamp numeric,
	circlet_count numeric,
	seed_played text,
	is_trial bool,
	character_chosen text,
	campfire_rested numeric,
	gold numeric,
	neow_bonus text,
	is_prod bool,
	is_daily bool,
	chose_seed bool,
	campfire_upgraded numeric,
	win_rate numeric,
	timestamp numeric,
	build_version text,
	purchased_purges numeric,
	victory bool,
	player_experience numeric,
	is_beta bool,
	is_endless bool,
	killed_by text,
	ascension_level numeric,
	special_seed numeric,
	neow_cos3 text,
	idx bigint primary key
);


CREATE TABLE boss_relics(
	not_picked text[],
	picked text,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE campfire_choices(
	data text,
	floor numeric,
	key text,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE card_choices(
	not_picked text[],
	picked text,
	floor numeric,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE damage_taken(
	damage numeric,
	enemies text,
	floor numeric,
	turns numeric,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE event_choices(
	damage_healed numeric,
	gold_gain numeric,
	player_choice text,
	damage_taken numeric,
	relics_obtained text[],
	max_hp_gain numeric,
	max_hp_loss numeric,
	event_name text,
	floor numeric,
	gold_loss numeric,
	cards_upgraded text[],
	cards_removed text[],
	cards_transformed text[],
	cards_obtained text[],
	relics_lost text[],
	potions_obtained text[],
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE potions_obtained(
	floor numeric,
	key text,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


CREATE TABLE relics_obtained(
	floor numeric,
	key text,
	idx bigint references event(idx) ON DELETE CASCADE NOT NULL
);


