# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  account_type                    :string           default("agent")
#  active                          :boolean
#  address                         :string
#  address_scan_quota              :integer          default(0)
#  address_scan_state              :string
#  address_scan_trial_created_at   :datetime
#  address_scan_trial_ended_at     :datetime
#  address_scan_until              :datetime
#  admin                           :boolean          default(FALSE)
#  as_subscription_state           :string
#  as_subscription_until           :date
#  banned_at                       :datetime
#  beta_expired_at                 :datetime
#  beta_status                     :string
#  cgu_version                     :string
#  confirmation_sent_at            :datetime
#  confirmation_token              :string
#  confirmed_at                    :datetime
#  current_login_token             :string
#  current_sign_in_at              :datetime
#  current_sign_in_ip              :inet
#  custom_report_color             :string
#  custom_report_color_font        :string           default("#FFF")
#  custom_report_conclusion_color  :string
#  custom_report_hightlight_color  :string
#  deleted                         :boolean          default(FALSE)
#  description                     :text
#  email                           :string           default(""), not null
#  email_mailing                   :string
#  encrypted_password              :string           default(""), not null
#  first_name                      :string
#  first_time                      :boolean          default(TRUE)
#  iad_mandates_db_sync_at         :datetime
#  language                        :string
#  last_email_notification_sent_at :datetime         default(Fri, 05 May 2017 10:46:08.000000000 CEST +02:00)
#  last_name                       :string
#  last_notified_following_at      :datetime
#  last_sign_in_at                 :datetime
#  last_sign_in_ip                 :inet
#  last_viewed_following_at        :datetime
#  login                           :string
#  login_token                     :string
#  login_token_valid_until         :datetime
#  logo_url                        :string
#  migration_done                  :boolean
#  name                            :string
#  network                         :string           default("iad")
#  notification_by_email           :boolean
#  notification_by_facebook        :boolean
#  onboarding_completed            :boolean
#  phone                           :string
#  photo_url                       :string
#  plan                            :string
#  profile_photo_content_type      :string
#  profile_photo_file_name         :string
#  profile_photo_file_size         :integer
#  profile_photo_updated_at        :datetime
#  promo_code                      :string
#  referral_uniq_code              :string
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  rgpd_prospect_retention_month   :integer          default(36)
#  sandbox                         :boolean          default(FALSE)
#  sign_in_count                   :integer          default(0), not null
#  subscription_created_at         :datetime
#  subscription_ended_at           :datetime
#  tags                            :string           default([]), is an Array
#  title                           :string
#  unconfirmed_email               :string
#  uniq_connection_url             :string
#  uuid                            :string
#  website                         :string
#  with_old_premium                :boolean          default(FALSE)
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  customer_id                     :bigint
#  iad_id                          :string
#  premium_user_id                 :integer
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_iad_id                (iad_id)
#  index_users_on_login                 (login) UNIQUE
#  index_users_on_login_token           (login_token)
#  index_users_on_network               (network)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
 
  
end
