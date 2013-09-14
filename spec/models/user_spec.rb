require 'spec_helper'

describe User do
  before { @user = User.new(email: "foo@foo.bar") }

  subject { @user }

  it { should respond_to(:email) }

end
