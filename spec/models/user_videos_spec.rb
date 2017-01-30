require "spec_helper"

describe UserVideo do
  it { should belong_to(:user)}
  it { should belong_to(:video)}
end
