DROP TABLE IF EXISTS
    flowers,
    pests_diseases,
    flowers_diseases,
    flowers_pests,
    pests,
    diseases,
    fertilizers,
    watering_info,
    water_info,
    light_info,
    soils,
    climate_type,
    scheduler
    CASCADE;

DROP TYPE IF EXISTS
    quality,
    type_light,
    type_diseases,
    water_type,
    fertilizer_type,
    climate_types,
    soils_type;
