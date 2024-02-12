module Types {
  module User {
    enum ActivityClass {
      SEDENTARY = 1.2,
      LIGHTLY_ACTIVE = 1.375,
      MODERATELY_ACTIVE = 1.55,
      ACTIVE = 1.725,
      VERY_ACTIVE = 1.9,
    }

    const DEFAULT_FEMALE_DAILY_CALORIES = 2000;
    const DEFAULT_GENERIC_DAILY_CALORIES = 2250;
    const DEFAULT_MALE_DAILY_CALORIES = 2500;

    const MALE_BMR_SCALING_VALUE = 5;
    const FEMALE_BMR_SCALING_VALUE = -161;
  }
}
